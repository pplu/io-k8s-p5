package IO::K8s::Cilium::V2::CiliumLoadBalancerIPPool;
# ABSTRACT: Cilium load balancer IP address pool
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumloadbalancerippools';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;
