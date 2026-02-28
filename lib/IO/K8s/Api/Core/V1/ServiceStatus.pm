package IO::K8s::Api::Core::V1::ServiceStatus;
# ABSTRACT: ServiceStatus represents the current status of a service.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

Current service state

=cut

k8s loadBalancer => 'Core::V1::LoadBalancerStatus';

=attr loadBalancer

LoadBalancer contains the current status of the load-balancer, if one is present.

=cut

1;
