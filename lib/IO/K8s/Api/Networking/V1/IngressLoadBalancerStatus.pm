package IO::K8s::Api::Networking::V1::IngressLoadBalancerStatus;
# ABSTRACT: IngressLoadBalancerStatus represents the status of a load-balancer.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s ingress => ['Networking::V1::IngressLoadBalancerIngress'];

=attr ingress

ingress is a list containing ingress points for the load-balancer.

=cut

1;
