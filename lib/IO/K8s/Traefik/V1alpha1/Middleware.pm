package IO::K8s::Traefik::V1alpha1::Middleware;
# ABSTRACT: Middleware is the CRD implementation of a Traefik Middleware.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'middlewares';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::MiddlewareBuilder';

k8s spec => '+IO::K8s::Traefik::V1alpha1::MiddlewareSpec', { required => 'schema' };

=attr spec

MiddlewareSpec defines the desired state of a Middleware.

=cut

1;
