package IO::K8s::Traefik::V1alpha1::ServersTransportTCP;
# ABSTRACT: ServersTransportTCP is the CRD implementation of a TCPServersTransport.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'serverstransporttcps';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::Traefik::V1alpha1::ServersTransportTCPSpec', { required => 'schema' };

=attr spec

ServersTransportTCPSpec defines the desired state of a ServersTransportTCP.

=cut

1;
