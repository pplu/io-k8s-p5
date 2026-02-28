package IO::K8s::Api::Networking::V1::IngressStatus;
# ABSTRACT: IngressStatus describe the current state of the Ingress.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s loadBalancer => 'Networking::V1::IngressLoadBalancerStatus';

=attr loadBalancer

loadBalancer contains the current status of the load-balancer.

=cut

1;
