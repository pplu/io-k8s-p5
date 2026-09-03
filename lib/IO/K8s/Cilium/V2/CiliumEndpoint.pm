package IO::K8s::Cilium::V2::CiliumEndpoint;
# ABSTRACT: CiliumEndpoint is the status of a Cilium policy rule.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumendpoints';
with 'IO::K8s::Role::Namespaced';

k8s status => '+IO::K8s::Cilium::V2::EndpointStatus';

=attr status

EndpointStatus is the status of a Cilium endpoint.

=cut

1;
