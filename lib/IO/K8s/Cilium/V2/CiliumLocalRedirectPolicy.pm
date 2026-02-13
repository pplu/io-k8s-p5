package IO::K8s::Cilium::V2::CiliumLocalRedirectPolicy;
# ABSTRACT: Cilium local redirect policy for traffic steering
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumlocalredirectpolicies';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;
