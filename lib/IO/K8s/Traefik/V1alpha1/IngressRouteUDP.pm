package IO::K8s::Traefik::V1alpha1::IngressRouteUDP;
# ABSTRACT: IngressRouteUDP is a CRD implementation of a Traefik UDP Router.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'ingressrouteudps';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::Traefik::V1alpha1::IngressRouteUDPSpec', { required => 'schema' };

=attr spec

IngressRouteUDPSpec defines the desired state of a IngressRouteUDP.

=cut

1;
