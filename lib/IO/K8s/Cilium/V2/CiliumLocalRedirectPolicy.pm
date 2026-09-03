package IO::K8s::Cilium::V2::CiliumLocalRedirectPolicy;
# ABSTRACT: CiliumLocalRedirectPolicy is a Kubernetes Custom Resource that contains a specification to redirect traffic locally within a node.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumlocalredirectpolicies';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::Cilium::V2::CiliumLocalRedirectPolicySpec';
k8s status => '+IO::K8s::Cilium::V2::CiliumLocalRedirectPolicyStatus';

=attr spec

Spec is the desired behavior of the local redirect policy.

=cut

=attr status

Status is the most recent status of the local redirect policy.
It is a read-only field.

=cut

1;
