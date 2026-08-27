package IO::K8s::Role::Resource;
# ABSTRACT: Role providing Kubernetes resource instance behavior
our $VERSION = '1.108';
use v5.10;
use Moo::Role;
use JSON::MaybeXS ();
use Scalar::Util qw(blessed);

has json => (
    is      => 'ro',
    lazy    => 1,
    builder => '_build_json',
);

sub _build_json {
    return JSON::MaybeXS->new(utf8 => 1, canonical => 1);
}

# The registry lookup is the hot path (every inflate / TO_JSON), so the
# merged views are cached per class. IO::K8s::Resource::_k8s() invalidates
# the affected entries whenever it registers a new attribute.
my %_attr_info_cache;
my %_attributes_cache;

# Get merged attribute info from the global registry in IO::K8s::Resource,
# walking @ISA so a consumer subclass registered via class_namespaces sees
# its parents' attributes. Nearest wins: a class's own entry for a name
# beats any inherited one; @ISA order (depth-first, left to right) is
# deterministic, so diamond shapes resolve to the first declarer.
sub _k8s_attr_info {
    my ($class) = @_;
    $class = ref($class) if ref($class);
    return $_attr_info_cache{$class} //= _merged_attr_info($class);
}

sub _merged_attr_info {
    my ($class) = @_;
    my %info = %{ $IO::K8s::Resource::_attr_registry{$class} // {} };
    no strict 'refs';
    for my $parent (@{"${class}::ISA"}) {
        my $parent_info = _merged_attr_info($parent);
        for my $attr (keys %$parent_info) {
            $info{$attr} //= $parent_info->{$attr};
        }
    }
    return \%info;
}

# Get attribute list (stored as per-class package variables), merged with
# ancestors as a UNION: a class's own declarations first, then each parent's
# in @ISA order, deduplicated so an overridden name appears once.
sub _k8s_attributes {
    my ($self) = @_;
    my $class = ref($self) || $self;
    return $_attributes_cache{$class} //= _collect_attributes($class);
}

sub _collect_attributes {
    my ($class) = @_;
    my (@attrs, %seen);
    _append_attributes($class, \@attrs, \%seen);
    return \@attrs;
}

sub _append_attributes {
    my ($class, $attrs, $seen) = @_;
    no strict 'refs';
    for my $attr (@{"${class}::_k8s_attributes"}) {
        next if $seen->{$attr}++;
        push @$attrs, $attr;
    }
    for my $parent (@{"${class}::ISA"}) {
        _append_attributes($parent, $attrs, $seen);
    }
}

# Invalidate the merged-view caches for a class and every cached descendant
# after IO::K8s::Resource::_k8s() registers a new attribute. The direct hit
# covers the registering class; the descendant sweep covers a class whose
# merged view was already computed before its parent gained the attribute
# (the same subclass drift this module exists to fix).
sub _invalidate_k8s_attr_cache {
    my ($class) = @_;
    delete $_attr_info_cache{$class};
    delete $_attributes_cache{$class};
    my %sweep;
    @sweep{keys %_attr_info_cache, keys %_attributes_cache} = ();
    for my $cached_class (keys %sweep) {
        next if $cached_class eq $class;
        next unless $cached_class->isa($class);
        delete $_attr_info_cache{$cached_class};
        delete $_attributes_cache{$cached_class};
    }
}

sub TO_JSON {
    my $self = shift;
    my %data;
    my $attrs = $self->_k8s_attributes;
    my $info = _k8s_attr_info($self);

    # Add apiVersion, kind, and metadata for APIObjects (those with the role)
    if ($self->can('_is_resource') && $self->_is_resource) {
        $data{apiVersion} = $self->api_version if $self->api_version;
        $data{kind} = $self->kind if $self->kind;
        # metadata comes from the Role, not from k8s DSL
        if ($self->can('metadata') && $self->metadata) {
            $data{metadata} = $self->metadata->TO_JSON;
        }
    }

    for my $attr (@$attrs) {
        my $value = $self->$attr;
        next unless defined $value;

        my $attr_info = $info->{$attr} // {};
        # Use json_key for output when attr name differs from JSON field name
        my $key = $attr_info->{json_key} // $attr;

        if ($attr_info->{is_bool}) {
            $data{$key} = $value ? JSON::MaybeXS::true : JSON::MaybeXS::false;
        } elsif ($attr_info->{is_int}) {
            $data{$key} = int($value);
        } elsif ($attr_info->{is_int_or_string}) {
            $data{$key} = ($value =~ /\A-?\d+\z/) ? int($value) : $value;
        } elsif ($attr_info->{is_object} && blessed($value) && $value->can('TO_JSON')) {
            $data{$key} = $value->TO_JSON;
        } elsif ($attr_info->{is_array_of_objects}) {
            $data{$key} = [ map { $_->TO_JSON } @$value ];
        } elsif ($attr_info->{is_hash_of_objects}) {
            $data{$key} = { map { $_ => $value->{$_}->TO_JSON } keys %$value };
        } elsif ($attr_info->{is_array_of_int}) {
            $data{$key} = [ map { int($_) } @$value ];
        } elsif ($attr_info->{is_array_of_bool}) {
            # An undef ELEMENT dies rather than becoming a silent false
            # (karr #51). ArrayRef[Bool] accepts undef because
            # Types::Standard::Bool does, and _normalize_bool deliberately
            # returns it via an explicit `return undef` so the array coercer
            # keeps the position -- but there is nothing honest to put on the
            # wire here. The attribute-level answer (karr #48: leave it unset,
            # omit the field) does not apply inside an array, where omitting
            # would shift every later element; and the only field of this
            # shape upstream (Api::Resource::V1*::DeviceAttribute bools) is a
            # "non-empty list of true/false values", so a JSON null would be
            # schema-invalid too. Message names field and index, in the karr
            # #42 diagnostic style.
            my @bools;
            for my $i (0 .. $#$value) {
                die 'Bool value must not be undef at element ' . $i
                    . ' while serializing ' . (ref($self) || $self)
                    . " field $key\n" unless defined $value->[$i];
                push @bools, $value->[$i] ? JSON::MaybeXS::true : JSON::MaybeXS::false;
            }
            $data{$key} = \@bools;
        } elsif (ref $value eq 'ARRAY') {
            # Shallow copy, one level (karr #54): the struct must not alias the
            # object, or post-processing what TO_JSON returned silently edits
            # the object and every later serialization. Deliberately one level
            # only -- a nested structure under an opaque hash attribute
            # (fieldsV1, a free-form HashRef) still shares its inner refs with
            # the object. Same depth on the way in, in IO::K8s::_inflate_struct.
            $data{$key} = [ @$value ];
        } elsif (ref $value eq 'HASH') {
            # Shallow copy, one level -- see the ARRAY branch above (karr #54).
            $data{$key} = { %$value };
        } else {
            $data{$key} = $value;
        }
    }
    return \%data;
}

sub to_json {
    my $self = shift;
    return $self->json->encode($self->TO_JSON);
}

sub TO_YAML {
    my $self = shift;
    require YAML::PP;
    my $yp = YAML::PP->new(schema => [qw/JSON/], boolean => 'JSON::PP');
    return $yp->dump_string($self->TO_JSON);
}

sub to_yaml {
    my $self = shift;
    return $self->TO_YAML;
}

# The inflation that FROM_HASH routes through lives on an IO::K8s instance,
# and FROM_HASH is a class method, so it borrows one shared default instance.
# That is sound because the only thing it uses the instance for is
# _struct_to_object_expanded(), which is handed class names taken straight out
# of the attribute registry -- already fully expanded, so no resource_map, no
# class_namespaces and no openapi_spec of any *particular* IO::K8s instance is
# consulted. A caller who needs their own providers to take part in the
# resolution has $k8s->inflate / ->json_to_object, which start from a Kind.
#
# `require`, not a top-level `use`: IO::K8s loads IO::K8s::Resource, which
# loads this role, so a compile-time use here would close a load cycle.
sub _default_k8s {
    require IO::K8s;
    state $k8s = IO::K8s->new;
    return $k8s;
}

=method FROM_HASH

    my $pod = IO::K8s::Api::Core::V1::Pod->FROM_HASH($struct);

Builds an object of this class from a plain hashref of JSON field names,
inflating nested objects, arrays of objects and hashes of objects through the
attribute registry -- the same inflation L<IO::K8s/inflate> performs, so a
struct from L</TO_JSON> round-trips back (karr #59). Before 1.108 this was a
bare C<< $class->new(%$hash) >> and any nested field had to be pre-built.

=cut

sub FROM_HASH {
    my ($class, $hash) = @_;
    return _default_k8s()->_struct_to_object_expanded($class, $hash);
}

=method from_json

    my $pod = IO::K8s::Api::Core::V1::Pod->from_json($json_bytes);

Builds an object of this class from a JSON document, symmetric to
L</to_json>. The argument is a B<UTF-8 encoded byte string> -- exactly what
C<to_json> produces; a decoded character string is not accepted and fails
loudly in the JSON decoder rather than silently round-tripping to mojibake
(karr #53). Decode-tolerance was rejected on purpose: it would leave
C<from_json> more permissive than C<< $k8s->json_to_object >>, which has
always been byte-oriented.

=cut

sub from_json {
    my ($class, $json_str) = @_;
    state $json = JSON::MaybeXS->new(utf8 => 1);
    return $class->FROM_HASH($json->decode($json_str));
}

# Compare local class attributes against OpenAPI schema
# Returns hashref with differences:
#   missing_locally  => [ attrs in schema but not in class ]
#   missing_in_schema => [ attrs in class but not in schema ]
#   type_mismatch    => [ { attr => $name, local => $type, schema => $type } ]
sub compare_to_schema {
    my ($class, $schema) = @_;
    $class = ref($class) if ref($class);

    # Use the merged @ISA view (same structure as the raw registry entry:
    # json_key plus type flags) so a class_namespaces-style subclass sees its
    # inherited attributes instead of an empty or partial registry entry.
    my $local_attrs = _k8s_attr_info($class);
    my $schema_props = $schema->{properties} // {};

    # Build json_key -> attr_name mapping for lookup
    my %json_to_attr;
    for my $attr (keys %$local_attrs) {
        my $jk = $local_attrs->{$attr}{json_key} // $attr;
        $json_to_attr{$jk} = $attr;
    }

    my %result = (
        missing_locally   => [],
        missing_in_schema => [],
        type_mismatch     => [],
    );

    # Check schema properties against local attributes
    for my $prop (keys %$schema_props) {
        my $attr = $json_to_attr{$prop};
        if (!defined $attr) {
            # Special case: metadata comes from Role, not k8s DSL
            next if $prop eq 'metadata' && $class->can('metadata');
            # apiVersion and kind also come from Role
            next if ($prop eq 'apiVersion' || $prop eq 'kind') && $class->can('_is_resource');
            push @{$result{missing_locally}}, $prop;
        } else {
            # Compare types
            my $local_type = _describe_local_type($local_attrs->{$attr});
            my $schema_type = _describe_schema_type($schema_props->{$prop});
            if ($local_type ne $schema_type) {
                push @{$result{type_mismatch}}, {
                    attr   => $prop,
                    local  => $local_type,
                    schema => $schema_type,
                };
            }
        }
    }

    # Check local attributes not in schema
    for my $attr (keys %$local_attrs) {
        my $jk = $local_attrs->{$attr}{json_key} // $attr;
        if (!exists $schema_props->{$jk}) {
            push @{$result{missing_in_schema}}, $jk;
        }
    }

    return \%result;
}

sub _describe_local_type {
    my ($info) = @_;
    return 'string'         if $info->{is_str};
    return 'integer'        if $info->{is_int};
    return 'int-or-string'  if $info->{is_int_or_string};
    return 'quantity'       if $info->{is_quantity};
    return 'date-time'      if $info->{is_time};
    return 'boolean'        if $info->{is_bool};
    return 'array<string>'  if $info->{is_array_of_str};
    return 'array<integer>' if $info->{is_array_of_int};
    return 'array<boolean>' if $info->{is_array_of_bool};
    return 'array<object>'  if $info->{is_array_of_objects};
    return 'hash<string>'   if $info->{is_hash_of_str};
    return 'hash<object>'   if $info->{is_hash_of_objects};
    return 'object'         if $info->{is_object};
    return 'unknown';
}

sub _describe_schema_type {
    my ($prop) = @_;
    if (my $ref = $prop->{'$ref'}) {
        return 'int-or-string' if $ref =~ /intstr\.IntOrString$/;
        return 'quantity'      if $ref =~ /resource\.Quantity$/;
        return 'date-time'     if $ref =~ /meta\.v1\.(Micro)?Time$/;
        return 'object';
    }
    my $type = $prop->{type} // 'unknown';
    my $format = $prop->{format} // '';
    return 'int-or-string' if $format eq 'int-or-string';
    return 'date-time'     if $format eq 'date-time';
    if ($type eq 'array') {
        my $items = $prop->{items} // {};
        if ($items->{'$ref'}) {
            return 'array<object>';
        }
        my $item_type = $items->{type} // 'unknown';
        return "array<$item_type>";
    }
    if ($type eq 'object' && $prop->{additionalProperties}) {
        my $add = $prop->{additionalProperties};
        if ($add->{'$ref'}) {
            return 'hash<object>';
        }
        my $val_type = $add->{type} // 'unknown';
        return "hash<$val_type>";
    }
    return $type;
}

1;
