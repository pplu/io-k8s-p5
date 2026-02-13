package IO::K8s::Cilium::V2alpha1::CiliumCIDRGroup;
# ABSTRACT: Cilium CIDR group for IP address management
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumcidrgroups';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;
