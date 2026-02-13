package IO::K8s::Cilium::V2::CiliumEndpoint;
# ABSTRACT: Cilium endpoint representing a pod's network state
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumendpoints';
with 'IO::K8s::Role::Namespaced';

k8s status => { Str => 1 };

1;
