package IO::K8s::Api::Core::V1::LoadBalancerStatus;
# ABSTRACT: LoadBalancerStatus represents the status of a load-balancer.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s ingress => ['Core::V1::LoadBalancerIngress'];

=attr ingress

Ingress is a list containing ingress points for the load-balancer. Traffic intended for the service should be sent to these ingress points.

=cut

1;
