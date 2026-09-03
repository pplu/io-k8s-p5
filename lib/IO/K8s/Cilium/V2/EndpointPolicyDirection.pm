package IO::K8s::Cilium::V2::EndpointPolicyDirection;
# ABSTRACT: EndpointPolicyDirection is the list of allowed identities per direction.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s adding    => ['+IO::K8s::Cilium::V2::IdentityTuple'];
k8s allowed   => ['+IO::K8s::Cilium::V2::IdentityTuple'];
k8s denied    => ['+IO::K8s::Cilium::V2::IdentityTuple'];
k8s enforcing => Bool, { required => 'schema' };
k8s removing  => ['+IO::K8s::Cilium::V2::IdentityTuple'];
k8s state     => Str;

=attr adding

Deprecated

=cut

=attr allowed

AllowedIdentityList is a list of IdentityTuples that species peers that are
allowed.

=cut

=attr denied

DenyIdentityList is a list of IdentityTuples that species peers that are
denied.

=cut

=attr enforcing

No description in the upstream schema.

=cut

=attr removing

Deprecated

=cut

=attr state

EndpointPolicyState defines the state of the Policy mode: "enforcing", "non-enforcing", "disabled"

=cut

1;
