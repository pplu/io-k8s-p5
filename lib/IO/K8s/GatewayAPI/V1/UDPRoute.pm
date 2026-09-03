package IO::K8s::GatewayAPI::V1::UDPRoute;
# ABSTRACT: UDPRoute provides a way to route UDP traffic.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'udproutes';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::GatewayAPI::V1::UDPRouteSpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1::UDPRouteStatus';

=attr spec

Spec defines the desired state of UDPRoute.

=cut

=attr status

Status defines the current state of UDPRoute.

=cut

1;
