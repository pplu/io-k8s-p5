package IO::K8s::Cilium::V2::CiliumNode;
# ABSTRACT: Cilium node configuration and status
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumnodes';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;
