package IO::K8s::AutoGen;
# ABSTRACT: Dynamically generate IO::K8s classes from OpenAPI schema
our $VERSION = '1.108';
use v5.10;
use strict;
use warnings;
use Carp qw(croak);
use Package::Stash;
use Scalar::Util qw(reftype);
use Types::Standard qw( Bool Int Str );

# Cache of generated classes
my %_generated;

# Default namespace for auto-generated classes
our $DEFAULT_NAMESPACE = 'IO::K8s::_AUTOGEN';

# Convert OpenAPI definition name to Perl class name
# With namespace 'MyProject::K8s':
#   helm.cattle.io.v1.HelmChart -> MyProject::K8s::helm::cattle::io::v1::HelmChart
sub def_to_class {
    my ($def_name, $namespace) = @_;
    $namespace //= $DEFAULT_NAMESPACE;
    my $class = $def_name;
    $class =~ s/\./::/g;
    return "${namespace}::$class";
}

# Convert Perl class name back to OpenAPI definition name
sub class_to_def {
    my ($class) = @_;
    # Strip any _AUTOGEN namespace prefix
    $class =~ s/^IO::K8s::_AUTOGEN_[^:]+:://;
    $class =~ s/^IO::K8s::_AUTOGEN:://;
    $class =~ s/::/./g;
    return $class;
}

# Check if a class was auto-generated
sub is_autogen {
    my ($class) = @_;
    return $class =~ /^IO::K8s::_AUTOGEN/;
}

# Get or generate a class from schema
# Options hash can include:
#   api_version      => 'stable.example.com/v1'
#   kind             => 'StaticWebSite'
#   resource_plural  => 'staticwebsites'
#   is_namespaced    => 1
sub get_or_generate {
    my ($def_name, $schema, $all_defs, $namespace, %opts) = @_;

    my $class = _class_name_for($def_name, $schema, $namespace, $opts{api_version});
    return $class if $_generated{$class};

    _generate_class($class, $def_name, $schema, $all_defs, $namespace, %opts);
    return $class;
}

# Class identity for a definition. A definition whose
# x-kubernetes-group-version-kind lists several entries serves more than
# one apiVersion from one schema; requesting one of them must produce a
# package specific to that GVK, otherwise the second version would silently
# reuse the first version's class (and its api_version method). The
# versionless generation keeps the plain def_to_class name as the
# deterministic compatibility default.
sub _class_name_for {
    my ($def_name, $schema, $namespace, $api_version) = @_;
    my $class = def_to_class($def_name, $namespace);
    return $class unless defined $api_version;

    my $gvk = $schema->{'x-kubernetes-group-version-kind'};
    return $class unless ref($gvk) eq 'ARRAY' && @$gvk > 1;

    # / and . are not valid in a package name, and a trailing segment must
    # be a bare identifier; map group/version to ::-separated segments the
    # same way def_to_class maps def_names.
    my $suffix = $api_version;
    $suffix =~ s{/}{::}g;
    $suffix =~ s{\.}{::}g;
    return "${class}::${suffix}";
}

# Wire apiVersion a GVK entry represents: group/version, or bare version
# when the group is empty (core group).
sub _gvk_api_version {
    my ($entry) = @_;
    my $group = $entry->{group} // '';
    my $version = $entry->{version} // '';
    return $group ? "$group/$version" : $version;
}

# Deterministic ordering key for a GVK entry.
sub _gvk_sort_key {
    my ($entry) = @_;
    return join '/',
        ($entry->{group} // ''),
        ($entry->{version} // ''),
        ($entry->{kind} // '');
}

# Pick the GVK entry a class should be built from.
#
# With an $api_version the request is exact: the entry whose group/version
# matches is returned; several matches are an ambiguity error, none is a
# fail-closed error. It never silently takes the first entry.
#
# Without an $api_version the entries are sorted and the first is returned
# -- deterministic regardless of array order.
sub _select_gvk_entry {
    my ($gvk, $api_version, $def_name) = @_;

    return $gvk unless ref($gvk) eq 'ARRAY';

    if (defined $api_version) {
        my @matches = grep { _gvk_api_version($_) eq $api_version } @$gvk;
        if (@matches > 1) {
            croak "GVK ambiguity in definition '$def_name': "
                . scalar(@matches)
                . " x-kubernetes-group-version-kind entries match api_version '$api_version'";
        }
        if (@matches == 1) {
            return $matches[0];
        }
        croak "No x-kubernetes-group-version-kind entry in definition '$def_name' "
            . "matches api_version '$api_version'";
    }

    return (sort { _gvk_sort_key($a) cmp _gvk_sort_key($b) } @$gvk)[0];
}

# Generate a class from OpenAPI schema using IO::K8s::Resource
sub _generate_class {
    my ($class, $def_name, $schema, $all_defs, $namespace, %opts) = @_;

    # Determine api_version/kind from schema or explicit options. This has
    # to happen before the class is marked generated: a fail-closed error
    # here (ambiguous or non-matching api_version) must not leave a
    # half-generated stub in the cache that a later retry would return.
    my ($api_ver, $kind_val, $res_plural, $is_namespaced);
    if (my $gvk = $schema->{'x-kubernetes-group-version-kind'}) {
        my $entry = _select_gvk_entry($gvk, $opts{api_version}, $def_name);
        my $group = $entry->{group} // '';
        my $version = $entry->{version} // '';
        $kind_val = $entry->{kind} // '';
        $api_ver = $group ? "$group/$version" : $version;
    }

    # Explicit options override schema-derived values. Hoisted above the
    # property loop because whether this class ends up with GVK class
    # methods decides which properties must not become attributes.
    $api_ver       = $opts{api_version}     if exists $opts{api_version};
    $kind_val      = $opts{kind}            if exists $opts{kind};
    $res_plural    = $opts{resource_plural} if exists $opts{resource_plural};
    $is_namespaced = $opts{is_namespaced}   if exists $opts{is_namespaced};

    return if $_generated{$class};
    $_generated{$class} = 1;  # Mark early to prevent recursion

    # Ensure parent packages exist
    _ensure_package_exists($class);

    # Set up the class using IO::K8s::Resource's shared setup method
    {
        no strict 'refs';
        @{"${class}::ISA"} = ();
    }

    require IO::K8s::Resource;
    IO::K8s::Resource->_setup_class($class);

    # Get the k8s function for this class
    my $k8s = $class->can('k8s')
        or croak "Failed to set up k8s DSL for $class";

    my $properties = $schema->{properties} // {};

    # A class that gets the GVK class methods below also gets
    # IO::K8s::Role::APIObject, and with it apiVersion, kind and metadata --
    # exactly the three properties IO::K8s::Role::Resource::compare_to_schema
    # already excuses a top-level object for not declaring, and the line
    # karr #45 drew for the hand-written template classes. Declaring them a
    # second time as schema properties is not merely redundant:
    #
    #   kind:       add_symbol('&kind') overwrites the generated accessor
    #               afterwards, so the attribute is write-only-looking and
    #               $obj->kind('Other') is a silent no-op (karr #60).
    #   apiVersion: no such collision, which is worse -- the attribute stays
    #               writable and TO_JSON emits it over the apiVersion the
    #               class actually is.
    #   metadata:   harmless but pure waste -- the role's own `has metadata`
    #               and the explicit k8s registration further down both land
    #               after the loop and overwrite whatever it built, having
    #               generated a throwaway ObjectMeta class on the way. It is
    #               skipped here so that a schema referencing the standard
    #               ObjectMeta without carrying its definition (a very common
    #               way to hand in a single CRD schema) does not trip the
    #               unresolved-$ref refusal below over a field the role
    #               supplies anyway.
    my %role_supplied = (defined $api_ver && defined $kind_val)
        ? (apiVersion => 1, kind => 1, metadata => 1)
        : ();

    # Generate attributes using k8s DSL
    # Property names with special characters ($ref, x-kubernetes-*) are
    # automatically sanitized to valid Perl identifiers by _k8s(), with
    # init_arg mapping so constructors still accept the original JSON keys.
    for my $prop (sort keys %$properties) {
        next if $role_supplied{$prop};
        my $prop_schema = $properties->{$prop};
        my $type_spec = _schema_to_type_spec($prop_schema, $all_defs, $namespace, $prop, $class);
        next unless defined $type_spec;  # Skip unsupported types

        $k8s->($prop, $type_spec);
    }

    # Install class methods if we have api_version/kind
    if (defined $api_ver && defined $kind_val) {
        my $stash = Package::Stash->new($class);

        # These are fixed identity methods, not writable fields. A caller
        # passing an argument believes they retargeted the object; fail closed
        # rather than swallow the write (karr #67, the house line of #37/#39).
        $stash->add_symbol('&api_version', sub {
            croak 'api_version is fixed for this class and cannot be set' if @_ > 1;
            $api_ver;
        });
        $stash->add_symbol('&kind', sub {
            croak 'kind is fixed for this class and cannot be set' if @_ > 1;
            $kind_val;
        });
        $stash->add_symbol('&resource_plural', sub {
            croak 'resource_plural is fixed for this class and cannot be set' if @_ > 1;
            $res_plural;
        });

        # Apply Role::APIObject for metadata, to_yaml, save, etc.
        require Moo::Role;
        require IO::K8s::Role::APIObject;
        Moo::Role->apply_roles_to_package($class, 'IO::K8s::Role::APIObject');

        # Register metadata attribute via k8s DSL so _inflate_struct knows the type
        # (same as IO::K8s::APIObject::import does for hand-written classes)
        $k8s->('metadata', 'Meta::V1::ObjectMeta');

        # Apply Namespaced role if requested or schema suggests it
        if ($is_namespaced) {
            require IO::K8s::Role::Namespaced;
            Moo::Role->apply_roles_to_package($class, 'IO::K8s::Role::Namespaced');
        }
    }

    return $class;
}

# Opaque type definitions that should be HashRef, not object references
my %OPAQUE_TYPES = map { $_ => 1 } qw(
    io.k8s.apimachinery.pkg.apis.meta.v1.FieldsV1
    io.k8s.apimachinery.pkg.runtime.RawExtension
);

# A $ref pointing at a definition the caller never supplied.
#
# Refusing is the fail-closed choice (karr #56). The property used to be
# skipped outright: the generated class simply had no such attribute, Moo
# dropped the constructor argument for it without a word, and TO_JSON never
# emitted the data again -- an inflate/serialize round-trip that quietly
# lost whatever sat under that key.
#
# The alternative considered was an opaque { Str => 1 } attribute. It was
# rejected for two reasons. It cannot be applied at all three call sites:
# the k8s DSL has no array-of-hash form, so `items: { $ref: <missing> }`
# would have to become ArrayRef[Str] and then reject the very hashrefs the
# field carries -- the karr #57 failure, reintroduced. And it guesses a
# shape: a missing definition may just as well be a string or array alias,
# in which case the Maybe[HashRef] attribute fails its type constraint
# without ever naming the unresolved $ref that caused it. %OPAQUE_TYPES
# above is a decision taken per named type, not a default for anything
# unresolvable.
sub _croak_unresolved_ref {
    my ($ref, $where) = @_;
    croak "Cannot resolve the \$ref '$ref' for $where: no such definition in "
        . "the OpenAPI spec. Supply the definition or drop the property -- "
        . "generating the class without it would silently drop that field on "
        . "every round-trip";
}

# Convert OpenAPI schema to k8s() type spec
#
# $field_name and $class are diagnostic context only: everything this
# function refuses has to name the class being generated and the field it
# choked on, because the caller sees neither (the karr #42 diagnostic line).
sub _schema_to_type_spec {
    my ($schema, $all_defs, $namespace, $field_name, $class) = @_;

    my $where = "field '" . $field_name . "' of " . $class;

    # Handle $ref
    if (my $ref = $schema->{'$ref'}) {
        $ref =~ s{^#/definitions/}{};

        # Special apimachinery types - not object references
        if ($ref =~ /intstr\.IntOrString$/) {
            return 'IntOrStr';
        }
        if ($ref =~ /resource\.Quantity$/) {
            return 'Quantity';
        }
        if ($ref =~ /meta\.v1\.(Micro)?Time$/) {
            return 'Time';
        }

        # Opaque types should be HashRef, not object references
        if ($OPAQUE_TYPES{$ref}) {
            return { Str => 1 };  # HashRef
        }

        # Generate referenced class if needed
        if ($all_defs && $all_defs->{$ref}) {
            my $ref_class = get_or_generate($ref, $all_defs->{$ref}, $all_defs, $namespace);
            return "+$ref_class";  # + prefix for full class name
        }
        _croak_unresolved_ref($ref, $where);
    }

    my $type = $schema->{type} // '';

    if ($type eq 'string') {
        my $format = $schema->{format} // '';
        return 'IntOrStr' if $format eq 'int-or-string';
        return 'Time'     if $format eq 'date-time';
        return 'Str';
    }
    elsif ($type eq 'integer') {
        return 'Int';
    }
    elsif ($type eq 'number') {
        return 'Num';  # A genuine JSON number -- unquoted on the wire (karr #68)
    }
    elsif ($type eq 'boolean') {
        return 'Bool';
    }
    elsif ($type eq 'array') {
        my $items = $schema->{items} // {};
        if (my $ref = $items->{'$ref'}) {
            $ref =~ s{^#/definitions/}{};
            if ($all_defs && $all_defs->{$ref}) {
                my $ref_class = get_or_generate($ref, $all_defs->{$ref}, $all_defs, $namespace);
                return ["+$ref_class"];
            }
            _croak_unresolved_ref($ref, "the items of $where");
        }
        # Type::Tiny objects rather than the barewords: inside an arrayref
        # the DSL reads a plain string as a class name for everything except
        # 'Str' and 'Int', so ['Bool'] would ask for an array of
        # IO::K8s::Api::Bool objects. [Bool] is the form that reaches the
        # is_array_of_bool branch and its per-element normalization, which is
        # what an array of schema-true JSON booleans needs (karr #57).
        my $item_type = $items->{type} // 'string';
        return [ Int ]  if $item_type eq 'integer';
        return [ Bool ] if $item_type eq 'boolean';
        # items: object / array with no further structure -> an array of
        # opaque hashes / opaque arrays. Before karr #66 both fell through to
        # [ Str ] below and rejected the very hashrefs/arrayrefs the schema
        # describes.
        return [ {} ] if $item_type eq 'object';
        return [ [] ] if $item_type eq 'array';
        return [ Str ];  # string, and the default for anything unmodelled
    }
    elsif ($type eq 'object') {
        my $addl = $schema->{additionalProperties};
        if (ref $addl eq 'HASH') {
            if (my $ref = $addl->{'$ref'}) {
                $ref =~ s{^#/definitions/}{};
                if ($all_defs && $all_defs->{$ref}) {
                    my $ref_class = get_or_generate($ref, $all_defs->{$ref}, $all_defs, $namespace);
                    return { "+$ref_class" => 1 };
                }
                _croak_unresolved_ref($ref, "the additionalProperties of $where");
            }
            return { Str => 1 };  # Hash of strings
        }
        # additionalProperties is allowed to be a JSON boolean instead of a
        # schema -- true: any extra property, false: none. A JSON::PP::Boolean
        # is a blessed scalar ref, so the $ref lookup above used to die "Not a
        # HASH reference" naming neither class nor field (karr #55). Neither
        # boolean says anything about the value types, so the field stays the
        # same opaque hash a schemaless object gets.
        if (defined $addl) {
            my $reftype = reftype($addl);
            croak "additionalProperties of $where is a " . $reftype
                . " reference; expected a schema object or a boolean"
                if defined $reftype && $reftype ne 'SCALAR';
        }
        return { Str => 1 };  # Generic object -> hash of strings
    }

    # Unknown type
    return 'Str';
}

# Ensure parent packages exist
sub _ensure_package_exists {
    my ($class) = @_;
    my @parts = split /::/, $class;
    pop @parts;  # Remove the final class name

    my $current = '';
    for my $part (@parts) {
        $current .= '::' if $current;
        $current .= $part;
        no strict 'refs';
        unless (%{"${current}::"}) {
            # Create empty package
            eval "package $current; 1;" or warn "Could not create package $current: $@";
        }
    }
}

# Clear generated class cache (mainly for testing)
sub clear_cache {
    %_generated = ();
}

# List all generated classes
sub generated_classes {
    return keys %_generated;
}

1;

__END__

=head1 NAME

IO::K8s::AutoGen - Dynamically generate IO::K8s classes from OpenAPI schema

=head1 SYNOPSIS

    use IO::K8s::AutoGen;

    # Generate a class from OpenAPI schema
    my $class = IO::K8s::AutoGen::get_or_generate(
        'helm.cattle.io.v1.HelmChart',
        $schema_definition,
        $all_definitions,
        'IO::K8s::_AUTOGEN_abc123',  # namespace
    );

    # The class is now available and works like any IO::K8s class
    my $obj = $class->new(metadata => $meta, spec => $spec);
    my $json = $obj->TO_JSON;

=head1 DESCRIPTION

This module dynamically generates Moo classes for Kubernetes custom resources
that don't have pre-generated IO::K8s classes.

Generated classes use C<IO::K8s::Resource> as their base, so they have:

=over 4

=item * The C<k8s> DSL for attribute definitions

=item * C<TO_JSON> / C<to_json> serialization

=item * C<_k8s_attr_info> for inflate support

=item * All standard IO::K8s behavior

=back

Generated classes are placed in a unique namespace per IO::K8s instance
to avoid collisions:

    IO::K8s::_AUTOGEN_abc123::helm::cattle::io::v1::HelmChart

=head1 FUNCTIONS

=head2 get_or_generate($def_name, $schema, $all_defs, $namespace)

Generate (or return cached) class for the given OpenAPI definition.

Extra positional options after C<$namespace> pin the identity of a
top-level object (C<< api_version => ..., kind => ..., resource_plural =>
..., is_namespaced => ... >>); the generated class then also composes
L<IO::K8s::Role::APIObject>.

When C<api_version> (or C<kind> / C<resource_plural>) is supplied, the
generated class installs fixed-value methods for each. These are fixed
identity, not writable fields: passing an argument croaks rather than
silently retargeting the object (k67, k70) -- the same contract the
hand-written CRD template installs via L<IO::K8s::APIObject>.

This function fails closed on input it cannot generate a faithful class
from, rather than dropping fields or inventing a wrong type. It C<croak>s
when:

=over 4

=item *

a property, an array's C<items>, or an C<additionalProperties> schema
carries a C<$ref> to a definition not present in C<$all_defs>. A partial
spec that references definitions it does not ship used to generate the
class anyway, minus those fields -- losing their data on every round-trip.
It now dies naming the C<$ref> and where it appeared (k56).

=item *

C<additionalProperties> is a reference that is neither a schema object nor
a JSON boolean; the message names the class and field (k55).

=item *

the schema's C<x-kubernetes-group-version-kind> metadata is ambiguous for
the requested C<api_version>, or names no entry matching it -- the GVK
selection fails closed rather than pick a version.

=back

One partial-spec shape still generates successfully by design: a top-level
CRD schema whose C<metadata> C<$ref>s the standard C<ObjectMeta> without
shipping its definition. C<metadata> is supplied by the role and is skipped
before its C<$ref> is looked at (k60), so this common single-schema
hand-in does not trip the unresolved-C<$ref> refusal. A side effect of that
skip: when C<$all_defs> does carry C<ObjectMeta> and nothing else
references it, it no longer appears in L</generated_classes()>.

=head2 def_to_class($def_name, $namespace)

Convert OpenAPI definition name to Perl class name.

=head2 class_to_def($class)

Convert Perl class name back to OpenAPI definition name.

=head2 is_autogen($class)

Returns true if the class was auto-generated.

=head2 clear_cache()

Clear the generated class cache.

=head2 generated_classes()

List all generated class names.

=cut
