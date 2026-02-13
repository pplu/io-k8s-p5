package IO::K8s::Cilium::V2::CiliumClusterwideNetworkPolicy;
# ABSTRACT: Cilium cluster-wide network policy
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumclusterwidenetworkpolicies';

k8s spec   => { Str => 1 };
k8s specs  => { Str => 1 };
k8s status => { Str => 1 };

1;
