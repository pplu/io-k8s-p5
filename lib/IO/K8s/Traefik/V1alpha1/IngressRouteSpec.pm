package IO::K8s::Traefik::V1alpha1::IngressRouteSpec;
# ABSTRACT: IngressRouteSpec defines the desired state of IngressRoute.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s entryPoints      => [Str];
k8s ingressClassName => Str;
k8s parentRefs       => ['Core::V1::SecretReference'];
k8s routes           => ['+IO::K8s::Traefik::V1alpha1::Route'], { required => 'schema' };
k8s tls              => '+IO::K8s::Traefik::V1alpha1::TLS';

=attr entryPoints

EntryPoints defines the list of entry point names to bind to.
Entry points have to be configured in the static configuration.
More info: https://doc.traefik.io/traefik/v3.7/reference/install-configuration/entrypoints/
Default: all.

=cut

=attr ingressClassName

IngressClassName defines the name of the IngressClass cluster resource.

=cut

=attr parentRefs

ParentRefs defines references to parent IngressRoute resources for multi-layer routing.
When set, this IngressRoute's routers will be children of the referenced parent IngressRoute's routers.
More info: https://doc.traefik.io/traefik/v3.7/routing/routers/#parentrefs

=cut

=attr routes

Routes defines the list of routes.

=cut

=attr tls

TLS defines the TLS configuration.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/routing/router/#tls

=cut

1;
