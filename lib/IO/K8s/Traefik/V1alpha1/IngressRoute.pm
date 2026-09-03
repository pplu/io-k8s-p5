package IO::K8s::Traefik::V1alpha1::IngressRoute;
# ABSTRACT: IngressRoute is the CRD implementation of a Traefik HTTP Router.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'ingressroutes';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Routable';
sub _route_format { 'traefik' }

k8s spec => '+IO::K8s::Traefik::V1alpha1::IngressRouteSpec', { required => 'schema' };

=attr spec

IngressRouteSpec defines the desired state of IngressRoute.

=cut

1;
