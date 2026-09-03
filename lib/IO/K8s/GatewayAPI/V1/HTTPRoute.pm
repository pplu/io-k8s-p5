package IO::K8s::GatewayAPI::V1::HTTPRoute;
# ABSTRACT: HTTPRoute provides a way to route HTTP requests.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'httproutes';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Routable';
sub _route_format { 'gateway' }

k8s spec   => '+IO::K8s::GatewayAPI::V1::HTTPRouteSpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1::HTTPRouteStatus';

=attr spec

Spec defines the desired state of HTTPRoute.

=cut

=attr status

Status defines the current state of HTTPRoute.

=cut

1;
