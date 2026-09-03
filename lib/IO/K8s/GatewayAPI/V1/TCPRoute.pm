package IO::K8s::GatewayAPI::V1::TCPRoute;
# ABSTRACT: TCPRoute provides a way to route TCP requests.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'tcproutes';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::GatewayAPI::V1::TCPRouteSpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1::TCPRouteStatus';

=attr spec

Spec defines the desired state of TCPRoute.

=cut

=attr status

Status defines the current state of TCPRoute.

=cut

1;
