package IO::K8s::Cilium::V2::CiliumNetworkPolicyStatus;
# ABSTRACT: Status is the status of the Cilium policy rule
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions         => ['Core::V1::NamespaceCondition'];
k8s derivativePolicies => { '+IO::K8s::Cilium::V2::CiliumNetworkPolicyNodeStatus' => 1 };

=attr conditions

No description in the upstream schema.

=cut

=attr derivativePolicies

DerivativePolicies is the status of all policies derived from the Cilium
policy

=cut

1;
