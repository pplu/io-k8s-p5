package IO::K8s::Traefik::V1alpha1::IngressRouteUDPSpec;
# ABSTRACT: IngressRouteUDPSpec defines the desired state of a IngressRouteUDP.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s entryPoints      => [Str];
k8s ingressClassName => Str;
k8s routes           => ['+IO::K8s::Traefik::V1alpha1::RouteUDP'], { required => 'schema' };

=attr entryPoints

EntryPoints defines the list of entry point names to bind to.
Entry points have to be configured in the static configuration.
More info: https://doc.traefik.io/traefik/v3.7/reference/install-configuration/entrypoints/
Default: all.

=cut

=attr ingressClassName

IngressClassName defines the name of the IngressClass cluster resource.

=cut

=attr routes

Routes defines the list of routes.

=cut

1;
