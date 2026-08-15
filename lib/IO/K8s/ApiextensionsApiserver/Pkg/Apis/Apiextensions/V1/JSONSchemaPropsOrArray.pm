package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaPropsOrArray;
# ABSTRACT: JSONSchemaPropsOrArray represents a value that can either be a JSONSchemaProps or an array of JSONSchemaProps. Mainly here for serialization purposes.
our $VERSION = '1.108';
use v5.10;
use Moo;
use Types::Standard qw( ArrayRef InstanceOf Maybe );
use JSON::MaybeXS ();

my $PROPS = 'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaProps';

=head1 DESCRIPTION

The union type behind C<items> in a CRD schema. Upstream it serializes as the
bare alternative, never as a tagged wrapper:

    items: { type: string }        # single schema  -> schema
    items: [ {...}, {...} ]        # tuple          -> schemas

Exactly one arm is populated, and which one it was survives a round trip: a
single schema never turns into a one-element array, and an array never
collapses into a single schema.

    my $items = $props->items;
    if ($items->is_schema) { ... $items->schema  ... }
    else                   { ... $items->schemas ... }

=cut

has schema => (
    is  => 'rw',
    isa => Maybe[InstanceOf[$PROPS]],
);

=attr schema

The single-schema arm: a
L<IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaProps>,
or C<undef> when the array arm is in use.

=cut

has schemas => (
    is  => 'rw',
    isa => Maybe[ArrayRef[InstanceOf[$PROPS]]],
);

=attr schemas

The array arm: an ArrayRef of C<JSONSchemaProps>, or C<undef> when the single
schema arm is in use. An empty ArrayRef is a populated arm and serializes as
C<[]>.

=cut

sub _build_json {
    return JSON::MaybeXS->new(utf8 => 1, canonical => 1, allow_nonref => 1);
}

=method is_schema

True when the single-schema arm is in use, false when the array arm is.

=cut

sub is_schema {
    my ($self) = @_;
    return defined $self->schemas ? 0 : 1;
}

=method FROM_STRUCT

    my $items = $class->FROM_STRUCT($struct, $k8s);

Inflation hook called by L<IO::K8s/struct_to_object>. An ArrayRef fills
C<schemas>, anything else fills C<schema>.

=cut

sub FROM_STRUCT {
    my ($class, $struct, $k8s) = @_;
    $k8s //= do { require IO::K8s; IO::K8s->new };

    return $class->new(
        schemas => [ map { $k8s->struct_to_object($PROPS, $_) } @$struct ],
    ) if ref $struct eq 'ARRAY';

    return $class->new(schema => $k8s->struct_to_object($PROPS, $struct));
}

=method TO_JSON

Returns the bare arm: an ArrayRef of serialized schemas, or the single
serialized schema.

=cut

sub TO_JSON {
    my ($self) = @_;
    my $schemas = $self->schemas;
    return [ map { $_->TO_JSON } @$schemas ] if defined $schemas;
    my $schema = $self->schema;
    return defined $schema ? $schema->TO_JSON : undef;
}

with 'IO::K8s::Role::Resource';

1;
