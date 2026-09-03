package IO::K8s::Resource;
# ABSTRACT: Base class for all Kubernetes resources
our $VERSION = '1.108';
use v5.10;
use Moo ();
use Moo::Role ();
use Import::Into;
use Package::Stash;
use Types::Standard qw( ArrayRef Bool HashRef InstanceOf Int Maybe Num Str );
use IO::K8s::Types qw( IntOrStr Quantity Time );
use IO::K8s::Role::Resource ();
use Scalar::Util qw( blessed reftype looks_like_number );
use Carp qw( croak );

# Registry: class -> attr -> { type, class, is_array, is_hash, is_bool, is_int }
# Use 'our' to make it a proper package variable accessible via symbol table
our %_attr_registry;

# Unknown-field policy (D1). Off: a constructor key no attribute claims is
# kept in the object's _unknown_fields bag and emitted again by TO_JSON, so
# a document from a newer upstream than the class still round-trips. On: it
# dies naming the class and the field. IO::K8s localizes this around its own
# entry points when built with strict => 1 (see IO::K8s/strict); nothing
# else writes it. A package variable rather than a constructor argument so
# that it reaches the inline-struct coercers, which call ->new directly and
# never pass through IO::K8s::_inflate_struct.
our $STRICT = 0;

# Class name expansion map
my %_class_prefix = (
    'Core'           => 'IO::K8s::Api::Core',
    'Apps'           => 'IO::K8s::Api::Apps',
    'Batch'          => 'IO::K8s::Api::Batch',
    'Networking'     => 'IO::K8s::Api::Networking',
    'Rbac'           => 'IO::K8s::Api::Rbac',
    'Storage'        => 'IO::K8s::Api::Storage',
    'Policy'         => 'IO::K8s::Api::Policy',
    'Autoscaling'    => 'IO::K8s::Api::Autoscaling',
    'Admissionregistration' => 'IO::K8s::Api::Admissionregistration',
    'Coordination'   => 'IO::K8s::Api::Coordination',
    'Discovery'      => 'IO::K8s::Api::Discovery',
    'Events'         => 'IO::K8s::Api::Events',
    'Flowcontrol'    => 'IO::K8s::Api::Flowcontrol',
    'Node'           => 'IO::K8s::Api::Node',
    'Scheduling'     => 'IO::K8s::Api::Scheduling',
    'Certificates'   => 'IO::K8s::Api::Certificates',
    'Authentication' => 'IO::K8s::Api::Authentication',
    'Authorization'  => 'IO::K8s::Api::Authorization',
    'Resource'       => 'IO::K8s::Api::Resource',
    'Storagemigration' => 'IO::K8s::Api::Storagemigration',
    'Lifecycle'      => 'IO::K8s::Api::Lifecycle',
    'Meta'           => 'IO::K8s::Apimachinery::Pkg::Apis::Meta',
    'Apiextensions'  => 'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions',
    'KubeAggregator' => 'IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration',
);

# Type flag lookup table
my %TYPE_FLAGS = (
    Str      => { is_str => 1 },
    Int      => { is_int => 1 },
    Num      => { is_num => 1 },
    Bool     => { is_bool => 1 },
    IntOrStr => { is_int_or_string => 1 },
    Quantity => { is_quantity => 1 },
    Time     => { is_time => 1 },
);

# For string path: map type name to base Type::Tiny constraint
# Custom K8s types (IntOrStr, Quantity, Time) fall back to Str
my %STR_ISA_MAP = (
    Str  => Str,
    Int  => Int,
    Num  => Num,
    Bool => Bool,
);

# Value types for the hash-of-scalar-type DSL form { TypeName => 1 } (k63).
# 'Str' is deliberately NOT here: it keeps its historical bare-HashRef meaning,
# the genuinely opaque string map that labels, annotations and fieldsV1 need.
# Everything here constrains each VALUE against the scalar type, so a map
# upstream declares as map[X]Quantity finally rejects cpu => 'banana' at
# construction instead of at the API server.
my %HASH_VALUE_TYPES = (
    Int      => { isa => Int,      flag => 'is_hash_of_int' },
    Num      => { isa => Num,      flag => 'is_hash_of_num' },
    Bool     => { isa => Bool,     flag => 'is_hash_of_bool' },
    Quantity => { isa => Quantity, flag => 'is_hash_of_quantity' },
    Time     => { isa => Time,     flag => 'is_hash_of_time' },
    IntOrStr => { isa => IntOrStr, flag => 'is_hash_of_int_or_string' },
);

# Field options a declaration may carry (D3): the third argument
# (`k8s name => Type, { ... }`) or, inside an inline struct, the two-element
# form `name => [ Type, { ... } ]`. The legacy 'required' marker and the
# `Type!` suffix still work and mean { required => 1 }. Everything here is
# recorded in the registry for to_crd; enum, minimum, maximum and pattern
# are also enforced at construction, the way { Quantity => 1 } validates
# its values -- a bad value fails here instead of at the API server.
# default is deliberately NOT applied client-side: defaulting is the API
# server's job, and a client default would change the wire output.
my %FIELD_OPTIONS = map { $_ => 1 } qw(
    required default enum minimum maximum pattern description nullable
    preserve_unknown
);
my %NUMERIC_KIND = (Int => 1, Num => 1);
my %STRING_KIND  = (Str => 1, IntOrStr => 1, Quantity => 1, Time => 1);

# The value constraints as child types of the field's base type, so a
# failure names the rule ("is not one of", "is below the minimum") rather
# than an anonymous intersection. $kind is the scalar type name the field
# is built on (Str, Int, Num, Bool, IntOrStr, Quantity, Time).
sub _constrain {
    my ($base, $kind, $opts, $where) = @_;
    my $type = $base;

    if (exists $opts->{enum}) {
        croak "k8s: 'enum' for $where must be a non-empty arrayref"
            unless ref $opts->{enum} eq 'ARRAY' && @{ $opts->{enum} };
        croak "k8s: 'enum' is not allowed on a Bool field ($where)" if $kind eq 'Bool';
        my %allowed = map { $_ => 1 } @{ $opts->{enum} };
        croak "k8s: 'enum' for $where has duplicate entries"
            unless @{ $opts->{enum} } == keys %allowed;
        my $list = join ', ', @{ $opts->{enum} };
        $type = $type->create_child_type(
            display_name => $type->display_name . '[enum]',
            constraint   => sub { defined $_ && exists $allowed{$_} },
            message      => sub { "Value \"$_\" is not one of: $list" },
        );
    }

    if (exists $opts->{minimum} || exists $opts->{maximum}) {
        croak "k8s: 'minimum' and 'maximum' need an Int or Num field, not $kind ($where)"
            unless $NUMERIC_KIND{$kind};
        my ($min, $max) = @{$opts}{qw(minimum maximum)};
        for my $bound ($min, $max) {
            croak "k8s: 'minimum' and 'maximum' for $where must be numbers"
                if defined $bound && !looks_like_number($bound);
        }
        croak "k8s: 'minimum' ($min) must not exceed 'maximum' ($max) for $where"
            if defined $min && defined $max && $min > $max;
        $type = $type->create_child_type(
            display_name => $type->display_name . '[range]',
            constraint   => sub {
                (!defined $min || $_ >= $min) && (!defined $max || $_ <= $max)
            },
            message      => sub {
                defined $min && $_ < $min
                    ? "Value \"$_\" is below the minimum $min"
                    : "Value \"$_\" is above the maximum $max";
            },
        );
    }

    if (exists $opts->{pattern}) {
        croak "k8s: 'pattern' needs a string field, not $kind ($where)"
            unless $STRING_KIND{$kind};
        my $re = ref $opts->{pattern} eq 'Regexp'
            ? $opts->{pattern}
            : eval { my $p = $opts->{pattern}; qr/$p/ };
        croak "k8s: 'pattern' for $where does not compile: $@" unless $re;
        $type = $type->create_child_type(
            display_name => $type->display_name . '[pattern]',
            constraint   => sub { defined $_ && $_ =~ $re },
            message      => sub { "Value \"$_\" does not match the pattern $re" },
        );
    }

    return $type;
}

# Options that only make sense on a scalar-bearing field. Object, struct
# and opaque container fields reject them at class load.
sub _reject_value_options {
    my ($opts, $where) = @_;
    croak "k8s: 'enum' needs a scalar field ($where)" if exists $opts->{enum};
    croak "k8s: 'minimum' and 'maximum' need a scalar field ($where)"
        if exists $opts->{minimum} || exists $opts->{maximum};
    croak "k8s: 'pattern' needs a scalar field ($where)" if exists $opts->{pattern};
}

sub import {
    my $class = shift;
    my $caller = caller;
    $class->_setup_class($caller);
}

sub _setup_class {
    my ($class, $target) = @_;
    Moo->import::into($target);
    Types::Standard->import::into($target, qw( Str Int Bool Num ));
    IO::K8s::Types->import::into($target, qw( IntOrStr Quantity Time ));
    Moo::Role->apply_roles_to_package($target, 'IO::K8s::Role::Resource');
    my $stash = Package::Stash->new($target);
    $stash->add_symbol('&k8s', sub { $class->_k8s($target, @_) });
}

sub _expand_class {
    my ($short) = @_;

    # +FullClassName - strip + and use as-is
    return substr($short, 1) if $short =~ /^\+/;

    # Already fully qualified?
    return $short if $short =~ /^IO::K8s::/;

    # Prefix match against %_class_prefix: try the longest key first so that
    # CamelCase prefixes like KubeAggregator win over a hypothetical shorter
    # substring. Anything in the map is canonical — the lookup IS the source
    # of truth, the regex is not. Unknown short names still fall through to
    # the IO::K8s::Api default so this stays backwards compatible.
    if ($short =~ /^([A-Z]\w*)::/) {
        for my $prefix (sort { length($b) <=> length($a) } keys %_class_prefix) {
            next unless $short =~ /^\Q$prefix\E::/;
            $short =~ s/^\Q$prefix\E:://;
            return $_class_prefix{$prefix} . '::' . $short;
        }
    }

    # Default: assume it's under IO::K8s::Api
    return "IO::K8s::Api::$short";
}

sub _is_type_tiny {
    my ($obj) = @_;
    return blessed($obj) && $obj->isa('Type::Tiny');
}

# Sanitize JSON field names into valid Perl identifiers for Moo attributes
# $ref -> _ref, $schema -> _schema, x-kubernetes-foo -> x_kubernetes_foo
sub _sanitize_attr_name {
    my ($name) = @_;
    return $name unless $name =~ /[^a-zA-Z0-9_]/;
    (my $safe = $name) =~ s/^\$/_/;
    $safe =~ s/-/_/g;
    return $safe;
}

# The one boolean normalization in the distribution: everything that can
# arrive on a Bool attribute, reduced to a plain 0/1 -- or undef, meaning
# "leave the field unset". Used by the Bool and [Bool] coercers below and,
# before the constructor even runs, by the is_bool branch of
# IO::K8s::_inflate_struct -- those two used to disagree (k37).
#
# Two traps, both of which silently flip false into true:
#   * every reference is true in Perl, so \0 (the bare false idiom) and a
#     JSON::PP::Boolean (a blessed ref to 0) must be dereferenced, not tested;
#   * 'false' is a non-empty string and therefore true, so the strings have to
#     be spelled out rather than left to truthiness.
#
# Anything that cannot mean true or false dies (k42): a non-scalar
# reference, and a scalar ref that dereferences to yet another reference
# (\\0 used to come out silently true). reftype, not ref, so that blessed
# scalar refs -- JSON::PP::Boolean, boolean.pm, Types::Serialiser, any
# bless \(my $x = 0) -- keep working. Messages end in \n deliberately:
# they are diagnostics, and the callers (Moo's coercion wrapper, the
# eval/rethrow in _inflate_struct) attach the attribute context.
sub _normalize_bool {
    my ($value) = @_;
    if (ref $value) {
        my $reftype = reftype($value);
        die "Bool value must be a scalar or scalar ref, got $reftype\n"
            unless $reftype eq 'SCALAR' || $reftype eq 'REF';
        $value = $$value;
        die 'Bool scalar ref dereferenced to another reference ('
            . ref($value) . "), not a boolean\n" if ref $value;
    }
    # Explicit undef stays undef: the attribute is Maybe[Bool], TO_JSON
    # omits undef, and "no value" must not turn into an explicit false on
    # the wire (k48). `return undef`, not bare `return` -- in the
    # [Bool] coercer's list context a bare return would drop the element.
    return undef unless defined $value;
    return 0 if lc($value) eq 'false';
    return $value ? 1 : 0;
}

sub _generate_inline_struct {
    my ($class_name, $fields) = @_;
    __PACKAGE__->_setup_class($class_name);
    for my $field_name (keys %$fields) {
        __PACKAGE__->_k8s($class_name, $field_name, $fields->{$field_name});
    }
}

sub _k8s {
    my ($class, $caller, $name, $type_spec, $marker) = @_;

    my $json_key  = $name;
    my $attr_name = _sanitize_attr_name($name);
    my $where     = "field '$name' of $caller";

    # Inline-struct form: name => [ Type, { options } ]. Exactly two elements
    # with a hashref second is unambiguous -- every array type spec ([Str],
    # ['Core::V1::Container'], [ {} ], [ [] ]) has one element.
    if (ref $type_spec eq 'ARRAY' && @$type_spec == 2 && ref $type_spec->[1] eq 'HASH') {
        ($type_spec, $marker) = @$type_spec;
    }

    my %opts;
    if (ref $marker eq 'HASH') {
        %opts = %$marker;
    } elsif (defined $marker && $marker eq 'required') {
        $opts{required} = 1;
    } elsif (defined $marker) {
        croak "k8s: third argument for $where must be 'required' or a hashref of field options, got '$marker'";
    }
    for my $key (sort keys %opts) {
        croak "k8s: unknown field option '$key' for $where (known: "
            . join(', ', sort keys %FIELD_OPTIONS) . ')'
            unless $FIELD_OPTIONS{$key};
    }
    # An option present with an undef value is a declaration error, not a
    # no-op: `pattern => $schema->{pattern}` on an upstream schema with no
    # pattern would otherwise compile to a match-everything regex instead
    # of simply not declaring the option, and the same silent trap applies
    # to every other option (an undef default is not a JSON null we model).
    for my $key (sort keys %opts) {
        croak "k8s: field option '$key' for $where must not be undef"
            unless defined $opts{$key};
    }
    my $required = delete $opts{required} ? 1 : 0;

    # `!` suffix on strings (legacy/alternative required syntax)
    if (!ref $type_spec && !_is_type_tiny($type_spec) && $type_spec =~ s/!$//) {
        $required = 1;
    } elsif (ref $type_spec eq 'ARRAY' && !ref($type_spec->[0]) && $type_spec->[0] =~ s/!$//) {
        $required = 1;
    }

    # Ensure the registry entry exists
    $_attr_registry{$caller} = {} unless exists $_attr_registry{$caller};

    # Every branch below sets $inner, the type of a present value; the
    # Maybe wrapping for an optional field happens once at the end.
    my %info;
    my $inner;

    # Handle Type::Tiny objects directly (Str, Int, Bool, IntOrStr, Quantity, Time)
    if (_is_type_tiny($type_spec)) {
        my $kind  = $type_spec->name;
        my $flags = $TYPE_FLAGS{$kind};
        if ($flags) {
            %info  = %$flags;
            $inner = _constrain($type_spec, $kind, \%opts, $where);
        }
    } elsif (!ref $type_spec) {
        if (my $flags = $TYPE_FLAGS{$type_spec}) {
            %info = %$flags;
            my $base = $STR_ISA_MAP{$type_spec} // Str;
            $inner = _constrain($base, $type_spec, \%opts, $where);
        } else {
            my $full_class = _expand_class($type_spec);
            $info{is_object} = 1;
            $info{class} = $full_class;
            _reject_value_options(\%opts, $where);
            $inner = InstanceOf[$full_class];
        }
    } elsif (ref $type_spec eq 'ARRAY') {
        my $elem = $type_spec->[0];
        # [ {} ] / [ [] ] -- an array of opaque hashes or opaque arrays, for a
        # schema whose items are `type: object` / `type: array` with no further
        # structure (k66). Validated as arrays of the right container
        # shape; the contents pass through untyped, the same one-level-copy
        # opaque handling a free-form HashRef gets in TO_JSON / _inflate_struct.
        if (ref $elem eq 'HASH') {
            $info{is_array_of_hash} = 1;
            _reject_value_options(\%opts, $where);
            $inner = ArrayRef[HashRef];
        } elsif (ref $elem eq 'ARRAY') {
            $info{is_array_of_array} = 1;
            _reject_value_options(\%opts, $where);
            $inner = ArrayRef[ArrayRef];
        # Handle [Str] with Type::Tiny object
        } elsif (_is_type_tiny($elem)) {
            my $kind = $elem->name;
            if ($kind eq 'Str') {
                $info{is_array_of_str} = 1;
            } elsif ($kind eq 'Int') {
                $info{is_array_of_int} = 1;
            } elsif ($kind eq 'Bool') {
                $info{is_array_of_bool} = 1;
            }
            $inner = ArrayRef[ _constrain($elem, $kind, \%opts, $where) ];
        } elsif ($elem eq 'Str') {
            $info{is_array_of_str} = 1;
            $inner = ArrayRef[ _constrain(Str, 'Str', \%opts, $where) ];
        } elsif ($elem eq 'Int') {
            $info{is_array_of_int} = 1;
            $inner = ArrayRef[ _constrain(Int, 'Int', \%opts, $where) ];
        } else {
            my $full_class = _expand_class($elem);
            $info{is_array_of_objects} = 1;
            $info{class} = $full_class;
            _reject_value_options(\%opts, $where);
            $inner = ArrayRef[InstanceOf[$full_class]];
        }
    } elsif (ref $type_spec eq 'HASH') {
        my @keys = keys %$type_spec;
        if (@keys == 1 && !ref($type_spec->{$keys[0]}) && $type_spec->{$keys[0]} eq '1') {
            # Hash-of-X pattern: { TypeName => 1 }
            my $vkind = $keys[0];
            if ($vkind eq 'Str') {
                $info{is_hash_of_str} = 1;
                # Use plain HashRef without inner constraint - K8s has nested hashes
                # in fields like fieldsV1, annotations, labels which can have any structure
                _reject_value_options(\%opts, $where);
                $inner = HashRef;
            } elsif (my $vt = $HASH_VALUE_TYPES{$vkind}) {
                # { Quantity => 1 } and friends: a typed value map. Each value
                # is validated against the scalar type (k63).
                $info{$vt->{flag}} = 1;
                $inner = HashRef[ _constrain($vt->{isa}, $vkind, \%opts, $where) ];
            } else {
                my $full_class = _expand_class($vkind);
                $info{is_hash_of_objects} = 1;
                $info{class} = $full_class;
                _reject_value_options(\%opts, $where);
                $inner = HashRef[InstanceOf[$full_class]];
            }
        } else {
            # Inline struct: { field => TypeSpec, ... }
            my $inner_class = $caller . '::_' . ucfirst($attr_name);
            _generate_inline_struct($inner_class, $type_spec);
            $info{is_object} = 1;
            $info{is_inline_struct} = 1;
            $info{class} = $inner_class;
            _reject_value_options(\%opts, $where);
            $inner = InstanceOf[$inner_class];
        }
    }

    croak "k8s: cannot interpret the type of $where" unless defined $inner;

    # A default that the field's own type rejects is a declaration error,
    # not something to discover when to_crd emits it.
    if (exists $opts{default} && !$inner->check($opts{default})) {
        croak "k8s: 'default' for $where fails the field's own type: "
            . $inner->get_message($opts{default});
    }

    my $isa = $required ? $inner : Maybe[$inner];

    $info{required} = 1 if $required;
    if (%opts) {
        # A one-level copy: the registry must not alias a caller's arrayref
        # (the common `enum => $schema->{enum}` idiom reads straight off a
        # shared upstream structure) and later see it mutated out from under
        # the constraint that was already built from it. A Regexp is
        # immutable, so 'pattern' needs no copy.
        my %stored = %opts;
        $stored{enum} = [ @{ $stored{enum} } ] if exists $stored{enum};
        $info{options} = \%stored;
    }

    # Store json_key when it differs from the Perl attribute name
    $info{json_key} = $json_key if $attr_name ne $json_key;

    # Register - use hash slice to copy values, not reference
    $_attr_registry{$caller}{$attr_name} = { %info };
    no strict 'refs';
    push @{"${caller}::_k8s_attributes"}, $attr_name;

    # The merged @ISA views in IO::K8s::Role::Resource are cached; a new
    # registration must not leave a stale merged view behind.
    IO::K8s::Role::Resource::_invalidate_k8s_attr_cache($caller);

    # Only create the attribute if it doesn't already exist (e.g., from a role)
    return if $caller->can($attr_name);

    # Call Moo's has — use init_arg to map JSON key to Perl-safe attribute name
    my $has = $caller->can('has');
    my @coerce;
    # Bool attributes: coerce \0/\1 refs, JSON booleans and 'true'/'false'
    # strings to plain 0/1
    if ($info{is_bool}) {
        @coerce = (coerce => \&_normalize_bool);
    }
    # Array of bool: the same normalization, per element. A bad element's
    # message gets the index appended so it can be found in the array.
    elsif ($info{is_array_of_bool}) {
        @coerce = (coerce => sub {
            return $_[0] unless ref $_[0] eq 'ARRAY';
            my $in = $_[0];
            my @out;
            for my $i (0 .. $#$in) {
                push @out, eval { _normalize_bool($in->[$i]) };
                if (my $err = $@) {
                    $err =~ s/\n\z//;
                    die "$err at element $i\n";
                }
            }
            return \@out;
        });
    }
    # Inline struct: coerce plain hashref to inner class instance
    elsif ($info{is_inline_struct}) {
        my $ic = $info{class};
        @coerce = (coerce => sub {
            return $_[0] if blessed($_[0]);
            return $ic->new(%{$_[0]}) if ref $_[0] eq 'HASH';
            return $_[0];
        });
    }
    $has->($attr_name, is => 'rw', isa => $isa, @coerce,
        ($required ? (required => 1) : ()),
        ($attr_name ne $json_key ? (init_arg => $json_key) : ()),
    );
}

1;

__END__

=encoding UTF-8

=head1 NAME

IO::K8s::Resource - Base class for Kubernetes resources

=head1 SYNOPSIS

    package IO::K8s::Api::Core::V1::Pod;
    use IO::K8s::Resource;

    k8s apiVersion => 'Str';
    k8s kind => 'Str';
    k8s metadata => 'Meta::V1::ObjectMeta';
    k8s spec => 'Core::V1::PodSpec';

    1;

=head1 DESCRIPTION

Base class that sets up Moo, inheritance, and provides the C<k8s> DSL.
Just C<use IO::K8s::Resource;> - no need for C<use Moo> or C<extends>.

=head1 EXPORTED FUNCTIONS

=head2 k8s

    k8s name => 'Str';
    k8s replicas => 'Int';
    k8s ratio => 'Num';                        # JSON number, unquoted on the wire
    k8s suspend => 'Bool';
    k8s spec => 'Core::V1::PodSpec';           # Short class name
    k8s containers => ['Core::V1::Container']; # Array of objects
    k8s labels => { Str => 1 };                # Opaque hash of strings
    k8s limits => { Quantity => 1 };           # Typed value map (also Int/Num/Bool/Time/IntOrStr)
    k8s rows => [ {} ];                         # Array of opaque hashes
    k8s matrix => [ [] ];                       # Array of opaque arrays
    k8s spec => {                              # Inline struct
        replicas => Int,
        selector => Str,
        template => { Str => 1 },
    };

The C<< { Str => 1 } >> form is a deliberately B<opaque> hash: any value is
accepted, for genuinely free-form maps such as labels, annotations and
C<fieldsV1>. C<< { Quantity => 1 } >> (and C<Int>, C<Num>, C<Bool>, C<Time>,
C<IntOrStr>) instead validates every value against that scalar type, so a
map upstream declares as C<map[X]Quantity> rejects a bad value at
construction rather than at the API server.

Inline structs auto-generate an inner class (e.g. C<MyClass::_Spec>) with
the declared fields. Hashrefs are auto-coerced to the inner class on
construction.

Short class names are auto-expanded:

    Core::V1::Pod      -> IO::K8s::Api::Core::V1::Pod
    Meta::V1::ObjectMeta -> IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ObjectMeta

Field names that are not valid Perl identifiers are automatically sanitized:
C<$ref> becomes C<_ref>, C<$schema> becomes C<_schema>, and hyphens are
replaced with underscores (C<x-kubernetes-foo> becomes C<x_kubernetes_foo>).
The original JSON key is preserved via C<init_arg> so constructors and
C<FROM_HASH> still accept the original names, and C<TO_JSON> outputs the
original keys.

    k8s '$ref' => Str;                          # Moo attr: _ref
    k8s 'x-kubernetes-list-type' => Str;        # Moo attr: x_kubernetes_list_type

=cut
