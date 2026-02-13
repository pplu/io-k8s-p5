package IO::K8s::Cilium::V2alpha1::CiliumEndpointSlice;
# ABSTRACT: Cilium endpoint slice for scalable endpoint tracking
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumendpointslices';

k8s endpoints => { Str => 1 };

1;
