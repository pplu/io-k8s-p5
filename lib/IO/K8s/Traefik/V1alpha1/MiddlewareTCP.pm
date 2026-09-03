package IO::K8s::Traefik::V1alpha1::MiddlewareTCP;
# ABSTRACT: MiddlewareTCP is the CRD implementation of a Traefik TCP middleware.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'middlewaretcps';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::MiddlewareBuilder';

k8s spec => '+IO::K8s::Traefik::V1alpha1::MiddlewareTCPSpec', { required => 'schema' };

=attr spec

MiddlewareTCPSpec defines the desired state of a MiddlewareTCP.

=cut

1;
