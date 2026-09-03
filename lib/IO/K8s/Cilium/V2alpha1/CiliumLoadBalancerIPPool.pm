package IO::K8s::Cilium::V2alpha1::CiliumLoadBalancerIPPool;
# ABSTRACT: CiliumLoadBalancerIPPool is a Kubernetes third-party resource which is used to defined pools of IPs which the operator can use to allocate and advertise IPs for Services of type LoadBalancer.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumloadbalancerippools';

k8s spec   => '+IO::K8s::Cilium::V2alpha1::CiliumLoadBalancerIPPoolSpec', { required => 'schema' };
k8s status => '+IO::K8s::Cilium::V2alpha1::CiliumLoadBalancerIPPoolStatus';

=attr spec

Spec is a human readable description for a BGP load balancer
ip pool.

=cut

=attr status

Status is the status of the IP Pool.

It might be possible for users to define overlapping IP Pools, we can't validate or enforce non-overlapping pools
during object creation. The Cilium operator will do this validation and update the status to reflect the ability
to allocate IPs from this pool.

=cut

1;
