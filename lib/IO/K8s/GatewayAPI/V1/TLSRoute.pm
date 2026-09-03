package IO::K8s::GatewayAPI::V1::TLSRoute;
# ABSTRACT: The TLSRoute resource is similar to TCPRoute, but can be configured to match against TLS-specific metadata.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'tlsroutes';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Routable';
sub _route_format { 'gateway' }

k8s spec   => '+IO::K8s::GatewayAPI::V1::TLSRouteSpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1::TLSRouteStatus';

=attr spec

Spec defines the desired state of TLSRoute.

=cut

=attr status

Status defines the current state of TLSRoute.

=cut

1;
