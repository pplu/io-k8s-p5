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
use Scalar::Util qw(blessed reftype);

# Registry: class -> attr -> { type, class, is_array, is_hash, is_bool, is_int }
# Use 'our' to make it a proper package variable accessible via symbol table
our %_attr_registry;

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

# Value types for the hash-of-scalar-type DSL form { TypeName => 1 } (karr #63).
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
# IO::K8s::_inflate_struct -- those two used to disagree (karr #37).
#
# Two traps, both of which silently flip false into true:
#   * every reference is true in Perl, so \0 (the bare false idiom) and a
#     JSON::PP::Boolean (a blessed ref to 0) must be dereferenced, not tested;
#   * 'false' is a non-empty string and therefore true, so the strings have to
#     be spelled out rather than left to truthiness.
#
# Anything that cannot mean true or false dies (karr #42): a non-scalar
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
    # the wire (karr #48). `return undef`, not bare `return` -- in the
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
    my ($class, $caller, $name, $type_spec, $required_marker) = @_;

    my $json_key = $name;
    my $attr_name = _sanitize_attr_name($name);

    # Ensure the registry entry exists
    $_attr_registry{$caller} = {} unless exists $_attr_registry{$caller};

    my %info;
    my $isa;
    my $required = $required_marker && $required_marker eq 'required' ? 1 : 0;

    # Check for ! suffix on strings (legacy/alternative required syntax)
    if (!ref $type_spec && !_is_type_tiny($type_spec) && $type_spec =~ s/!$//) {
        $required = 1;
    } elsif (ref $type_spec eq 'ARRAY' && !ref($type_spec->[0]) && $type_spec->[0] =~ s/!$//) {
        $required = 1;
    }

    # Handle Type::Tiny objects directly (Str, Int, Bool, IntOrStr, Quantity, Time)
    if (_is_type_tiny($type_spec)) {
        my $flags = $TYPE_FLAGS{$type_spec->name};
        if ($flags) {
            %info = %$flags;
            $isa = $required ? $type_spec : Maybe[$type_spec];
        }
    } elsif (!ref $type_spec) {
        if (my $flags = $TYPE_FLAGS{$type_spec}) {
            %info = %$flags;
            my $base = $STR_ISA_MAP{$type_spec} // Str;
            $isa = $required ? $base : Maybe[$base];
        } else {
            my $full_class = _expand_class($type_spec);
            $info{is_object} = 1;
            $info{class} = $full_class;
            $isa = $required ? InstanceOf[$full_class] : Maybe[InstanceOf[$full_class]];
        }
    } elsif (ref $type_spec eq 'ARRAY') {
        my $inner = $type_spec->[0];
        # [ {} ] / [ [] ] -- an array of opaque hashes or opaque arrays, for a
        # schema whose items are `type: object` / `type: array` with no further
        # structure (karr #66). Validated as arrays of the right container
        # shape; the contents pass through untyped, the same one-level-copy
        # opaque handling a free-form HashRef gets in TO_JSON / _inflate_struct.
        if (ref $inner eq 'HASH') {
            $info{is_array_of_hash} = 1;
            $isa = $required ? ArrayRef[HashRef] : Maybe[ArrayRef[HashRef]];
        } elsif (ref $inner eq 'ARRAY') {
            $info{is_array_of_array} = 1;
            $isa = $required ? ArrayRef[ArrayRef] : Maybe[ArrayRef[ArrayRef]];
        # Handle [Str] with Type::Tiny object
        } elsif (_is_type_tiny($inner)) {
            my $type_name = $inner->name;
            if ($type_name eq 'Str') {
                $info{is_array_of_str} = 1;
            } elsif ($type_name eq 'Int') {
                $info{is_array_of_int} = 1;
            } elsif ($type_name eq 'Bool') {
                $info{is_array_of_bool} = 1;
            }
            $isa = $required ? ArrayRef[$inner] : Maybe[ArrayRef[$inner]];
        } elsif ($inner eq 'Str') {
            $info{is_array_of_str} = 1;
            $isa = $required ? ArrayRef[Str] : Maybe[ArrayRef[Str]];
        } elsif ($inner eq 'Int') {
            $info{is_array_of_int} = 1;
            $isa = $required ? ArrayRef[Int] : Maybe[ArrayRef[Int]];
        } else {
            my $full_class = _expand_class($inner);
            $info{is_array_of_objects} = 1;
            $info{class} = $full_class;
            $isa = $required ? ArrayRef[InstanceOf[$full_class]] : Maybe[ArrayRef[InstanceOf[$full_class]]];
        }
    } elsif (ref $type_spec eq 'HASH') {
        my @keys = keys %$type_spec;
        if (@keys == 1 && !ref($type_spec->{$keys[0]}) && $type_spec->{$keys[0]} eq '1') {
            # Hash-of-X pattern: { TypeName => 1 }
            my $inner = $keys[0];
            if ($inner eq 'Str') {
                $info{is_hash_of_str} = 1;
                # Use plain HashRef without inner constraint - K8s has nested hashes
                # in fields like fieldsV1, annotations, labels which can have any structure
                $isa = $required ? HashRef : Maybe[HashRef];
            } elsif (my $vt = $HASH_VALUE_TYPES{$inner}) {
                # { Quantity => 1 } and friends: a typed value map. Each value
                # is validated against the scalar type (karr #63).
                $info{$vt->{flag}} = 1;
                $isa = $required ? HashRef[$vt->{isa}] : Maybe[HashRef[$vt->{isa}]];
            } else {
                my $full_class = _expand_class($inner);
                $info{is_hash_of_objects} = 1;
                $info{class} = $full_class;
                $isa = $required ? HashRef[InstanceOf[$full_class]] : Maybe[HashRef[InstanceOf[$full_class]]];
            }
        } else {
            # Inline struct: { field => TypeSpec, ... }
            my $inner_class = $caller . '::_' . ucfirst($attr_name);
            _generate_inline_struct($inner_class, $type_spec);
            $info{is_object} = 1;
            $info{is_inline_struct} = 1;
            $info{class} = $inner_class;
            $isa = $required ? InstanceOf[$inner_class] : Maybe[InstanceOf[$inner_class]];
        }
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
