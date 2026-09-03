package IO::K8s::Cilium::V2alpha1::CiliumEndpointSlice;
# ABSTRACT: CiliumEndpointSlice contains a group of CoreCiliumendpoints.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumendpointslices';

k8s endpoints => ['+IO::K8s::Cilium::V2alpha1::CoreCiliumEndpoint'], { required => 'schema' };
k8s namespace => Str;

=attr endpoints

Endpoints is a list of coreCEPs packed in a CiliumEndpointSlice

=cut

=attr namespace

Namespace indicate as CiliumEndpointSlice namespace.
All the CiliumEndpoints within the same namespace are put together
in CiliumEndpointSlice.

=cut

1;
