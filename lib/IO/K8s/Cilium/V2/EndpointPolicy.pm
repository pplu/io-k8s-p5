package IO::K8s::Cilium::V2::EndpointPolicy;
# ABSTRACT: EndpointPolicy represents the endpoint's policy by listing all allowed ingress and egress identities in combination with L4 port and protocol.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s egress  => '+IO::K8s::Cilium::V2::EndpointPolicyDirection';
k8s ingress => '+IO::K8s::Cilium::V2::EndpointPolicyDirection';

=attr egress

EndpointPolicyDirection is the list of allowed identities per direction.

=cut

=attr ingress

EndpointPolicyDirection is the list of allowed identities per direction.

=cut

1;
