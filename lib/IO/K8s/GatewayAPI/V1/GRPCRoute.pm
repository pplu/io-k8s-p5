package IO::K8s::GatewayAPI::V1::GRPCRoute;
# ABSTRACT: GRPCRoute provides a way to route gRPC requests.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'grpcroutes';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Routable';
sub _route_format { 'gateway' }

k8s spec   => '+IO::K8s::GatewayAPI::V1::GRPCRouteSpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1::GRPCRouteStatus';

=attr spec

Spec defines the desired state of GRPCRoute.

=cut

=attr status

Status defines the current state of GRPCRoute.

=cut

1;
