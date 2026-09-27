package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::JSON;
# ABSTRACT: JSON represents any valid JSON value. These types are supported: bool, int64, float64, string, []interface{}, map[string]interface{} and nil.
our $VERSION = '1.109';
use v5.10;
use Moo;
use JSON::MaybeXS ();

=head1 DESCRIPTION

C<apiextensions.k8s.io/v1.JSON> is a free-form value: whatever the CRD author
wrote for C<default>, C<example> or an C<enum> entry. It serializes as the bare
value, not as a wrapper object, so this class only carries the value through
inflation and back out again unchanged.

Inflation goes through L<IO::K8s/struct_to_object>, which hands any class
providing C<FROM_STRUCT> the raw structure instead of treating it as a hashref
of attributes.

    my $props = $k8s->struct_to_object(
        'Apiextensions::V1::JSONSchemaProps',
        { type => 'string', default => 'nginx' },
    );

    $props->default->value;    # 'nginx'
    $props->TO_JSON->{default} # 'nginx' — bare, not { value => 'nginx' }

=cut

has value => (
    is => 'rw',
);

=attr value

The wrapped value. Any Perl structure that survives JSON encoding: a plain
scalar, a hashref, an arrayref, a JSON boolean, or C<undef>.

=cut

sub _build__json_encoder {
    return JSON::MaybeXS->new(utf8 => 1, canonical => 1, allow_nonref => 1);
}

=method FROM_STRUCT

    my $json = $class->FROM_STRUCT($struct, $k8s);

Inflation hook called by L<IO::K8s/struct_to_object>. Wraps C<$struct>
unchanged, except that a hash or an array is copied one level -- the rule
inflation applies to every array or hash of scalars (k54, k169). A key added
to or removed from the source hash, or an element pushed onto the source
array, after inflation does not reach the object. A container nested inside
the value is not copied and still shares its contents with the source. A
plain scalar, C<undef> or a JSON boolean is kept as given.

=cut

sub FROM_STRUCT {
    my ($class, $struct, $k8s) = @_;
    # One level, not deeper (k169): the depth IO::K8s::_inflate_struct
    # copies an untyped value to (k54). _copy_one_level is the role's,
    # composed into this package by the `with` below and reached unqualified,
    # as IO::K8s::List does -- IO::K8s::_shallow_copy is the same rule but
    # would need IO::K8s loaded for a direct FROM_STRUCT call.
    return $class->new(value => _copy_one_level($struct));
}

=method TO_JSON

Returns the wrapped value, a hash or an array copied one level -- the same
depth L</FROM_STRUCT> copies on the way in and L<IO::K8s::Role::Resource/TO_JSON>
copies an untyped container on the way out (k54, k171). A key added to or
removed from the returned hash, or an element pushed onto the returned
array, does not reach the object; a container nested inside the value is
still shared with it. A plain scalar, C<undef> or a JSON boolean is returned
as it is.

=cut

sub TO_JSON {
    my ($self) = @_;
    # One level (k171), the output side of FROM_STRUCT's copy (k169);
    # _copy_one_level is the role's, as in FROM_STRUCT above.
    return _copy_one_level($self->value);
}

with 'IO::K8s::Role::Resource';

1;
