package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaPropsOrBool;
# ABSTRACT: JSONSchemaPropsOrBool represents JSONSchemaProps or a boolean value. Defaults to true for the boolean property.
our $VERSION = '1.108';
use v5.10;
use Moo;
use Types::Standard qw( Bool InstanceOf Maybe );
use Scalar::Util qw( blessed reftype );
use JSON::MaybeXS ();

my $PROPS = 'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaProps';

=head1 DESCRIPTION

The union type behind C<additionalProperties> and C<additionalItems> in a CRD
schema. Upstream it serializes as the bare alternative, never as a tagged
wrapper:

    additionalProperties: false          # boolean -> allows
    additionalProperties: { type: str }  # schema  -> schema

Exactly one arm is populated, and which one it was survives a round trip:
C<false> stays C<false> and never collapses into an empty schema object.

    my $ap = $props->additionalProperties;
    if ($ap->is_schema) { ... $ap->schema ... }
    else                { ... $ap->allows ... }

=cut

has schema => (
    is  => 'rw',
    isa => Maybe[InstanceOf[$PROPS]],
);

=attr schema

The schema arm: a
L<IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaProps>,
or C<undef> when the boolean arm is in use.

=cut

has allows => (
    is      => 'rw',
    isa     => Bool,
    default => 1,
);

=attr allows

The boolean arm, C<0> or C<1>. Defaults to C<1>, matching upstream. Only
consulted when C<schema> is C<undef>.

=cut

sub _build_json {
    return JSON::MaybeXS->new(utf8 => 1, canonical => 1, allow_nonref => 1);
}

=method is_schema

True when the schema arm is in use, false when the boolean arm is.

=cut

sub is_schema {
    my ($self) = @_;
    return defined $self->schema ? 1 : 0;
}

=method FROM_STRUCT

    my $ap = $class->FROM_STRUCT($struct, $k8s);

Inflation hook called by L<IO::K8s/struct_to_object>. A HashRef (or an already
built C<JSONSchemaProps>) fills C<schema>; anything else is read as a boolean
into C<allows>. JSON booleans, C<\1> / C<\0> scalar refs and the plain scalars
YAML::PP produces are all accepted.

=cut

sub FROM_STRUCT {
    my ($class, $struct, $k8s) = @_;

    if (ref $struct eq 'HASH' || (blessed($struct) && $struct->isa($PROPS))) {
        $k8s //= do { require IO::K8s; IO::K8s->new };
        return $class->new(schema => $k8s->struct_to_object($PROPS, $struct));
    }

    # Booleans arrive as JSON::PP::Boolean, \1 / \0, or plain scalars.
    my $bool = $struct;
    $bool = $$bool if ref($bool) && (reftype($bool) // '') eq 'SCALAR';

    return $class->new(allows => $bool ? 1 : 0);
}

=method TO_JSON

Returns the bare arm: the serialized schema, or a JSON boolean.

=cut

sub TO_JSON {
    my ($self) = @_;
    my $schema = $self->schema;
    return $schema->TO_JSON if defined $schema;
    return $self->allows ? JSON::MaybeXS::true() : JSON::MaybeXS::false();
}

with 'IO::K8s::Role::Resource';

1;
