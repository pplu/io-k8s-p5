package IO::K8s::Traefik::V1alpha1::ServersTransport;
# ABSTRACT: ServersTransport is the CRD implementation of a ServersTransport.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'serverstransports';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::Traefik::V1alpha1::ServersTransportSpec', { required => 'schema' };

=attr spec

ServersTransportSpec defines the desired state of a ServersTransport.

=cut

1;
