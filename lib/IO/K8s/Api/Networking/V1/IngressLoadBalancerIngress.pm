package IO::K8s::Api::Networking::V1::IngressLoadBalancerIngress;
# ABSTRACT: IngressLoadBalancerIngress represents the status of a load-balancer ingress point.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s hostname => Str;

=attr hostname

hostname is set for load-balancer ingress points that are DNS based.

=cut

k8s ip => Str;

=attr ip

ip is set for load-balancer ingress points that are IP based.

=cut

k8s ports => ['Networking::V1::IngressPortStatus'];

=attr ports

ports provides information about the ports exposed by this LoadBalancer.

=cut

1;
