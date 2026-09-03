package IO::K8s::AgentSandbox::V1beta1::NetworkPolicySpec;
# ABSTRACT: NetworkPolicySpec
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s egress  => ['Networking::V1::NetworkPolicyEgressRule'];
k8s ingress => ['Networking::V1::NetworkPolicyIngressRule'];

=attr egress

No description in the upstream schema.

=cut

=attr ingress

No description in the upstream schema.

=cut

1;
