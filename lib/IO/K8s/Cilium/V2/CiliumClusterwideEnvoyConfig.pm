package IO::K8s::Cilium::V2::CiliumClusterwideEnvoyConfig;
# ABSTRACT: Cilium cluster-wide Envoy proxy configuration
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumclusterwideenvoyconfigs';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;
