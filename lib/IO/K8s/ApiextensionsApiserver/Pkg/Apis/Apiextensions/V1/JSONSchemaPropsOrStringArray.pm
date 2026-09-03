package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaPropsOrStringArray;
# ABSTRACT: JSONSchemaPropsOrStringArray represents a JSONSchemaProps or a string array.
our $VERSION = '1.108';
use v5.10;
use Moo;
use Types::Standard qw( ArrayRef InstanceOf Maybe Str );
use JSON::MaybeXS ();

my $PROPS = 'IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaProps';

=head1 DESCRIPTION

The union type behind the values of C<dependencies> in a CRD schema. Upstream
it serializes as the bare alternative, never as a tagged wrapper:

    dependencies:
      creditCard: [ billingAddress ]   # string array -> property
      shipping:   { type: object }     # schema       -> schema

Exactly one arm is populated, and which one it was survives a round trip.

    my $dep = $props->dependencies->{creditCard};
    if ($dep->is_schema) { ... $dep->schema   ... }
    else                 { ... $dep->property ... }

=cut

has schema => (
    is  => 'rw',
    isa => Maybe[InstanceOf[$PROPS]],
);

=attr schema

The schema arm: a
L<IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSONSchemaProps>,
or C<undef> when the string array arm is in use.

=cut

has property => (
    is  => 'rw',
    isa => Maybe[ArrayRef[Str]],
);

=attr property

The string array arm: an ArrayRef of property names, or C<undef> when the
schema arm is in use. An empty ArrayRef is a populated arm and serializes as
C<[]>.

=cut

sub _build__json_encoder {
    return JSON::MaybeXS->new(utf8 => 1, canonical => 1, allow_nonref => 1);
}

=method is_schema

True when the schema arm is in use, false when the string array arm is.

=cut

sub is_schema {
    my ($self) = @_;
    return defined $self->property ? 0 : 1;
}

=method FROM_STRUCT

    my $dep = $class->FROM_STRUCT($struct, $k8s);

Inflation hook called by L<IO::K8s/struct_to_object>. An ArrayRef fills
C<property>, anything else fills C<schema>.

=cut

sub FROM_STRUCT {
    my ($class, $struct, $k8s) = @_;

    # Stringify so the arm always serializes as JSON strings; undef is left
    # alone so the ArrayRef[Str] constraint reports it instead of quietly
    # turning it into an empty string.
    return $class->new(property => [ map { defined($_) ? "$_" : undef } @$struct ])
        if ref $struct eq 'ARRAY';

    $k8s //= do { require IO::K8s; IO::K8s->new };
    return $class->new(schema => $k8s->_struct_to_object_expanded($PROPS, $struct));
}

=method TO_JSON

Returns the bare arm: an ArrayRef of property names, or the serialized schema.

=cut

sub TO_JSON {
    my ($self) = @_;
    my $property = $self->property;
    return [ @$property ] if defined $property;
    my $schema = $self->schema;
    return defined $schema ? $schema->TO_JSON : undef;
}

with 'IO::K8s::Role::Resource';

1;
