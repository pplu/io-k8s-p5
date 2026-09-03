package IO::K8s::Cilium::V2::CiliumClusterwideNetworkPolicy;
# ABSTRACT: CiliumClusterwideNetworkPolicy is a Kubernetes third-party resource with an modified version of CiliumNetworkPolicy which is cluster scoped rather than namespace scoped.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumclusterwidenetworkpolicies';
with 'IO::K8s::Role::NetworkPolicy';
sub _netpol_format { 'cilium' }

k8s spec   => '+IO::K8s::Cilium::V2::Rule';
k8s specs  => ['+IO::K8s::Cilium::V2::Rule'];
k8s status => '+IO::K8s::Cilium::V2::CiliumNetworkPolicyStatus';

=attr spec

Spec is the desired Cilium specific rule specification.

=cut

=attr specs

Specs is a list of desired Cilium specific rule specification.

=cut

=attr status

Status is the status of the Cilium policy rule.

The reason this field exists in this structure is due a bug in the k8s
code-generator that doesn't create a `UpdateStatus` method because the
field does not exist in the structure.

=cut

1;
