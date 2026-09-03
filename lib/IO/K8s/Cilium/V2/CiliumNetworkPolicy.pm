package IO::K8s::Cilium::V2::CiliumNetworkPolicy;
# ABSTRACT: CiliumNetworkPolicy is a Kubernetes third-party resource with an extended version of NetworkPolicy.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumnetworkpolicies';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::NetworkPolicy';
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

Status is the status of the Cilium policy rule

=cut

1;
