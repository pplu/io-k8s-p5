package IO::K8s::GatewayAPI::V1beta1::Gateway;
# ABSTRACT: Gateway represents an instance of a service-traffic handling infrastructure by binding Listeners to a set of IP addresses.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1beta1',
    resource_plural => 'gateways';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::GatewayAPI::V1beta1::GatewaySpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1beta1::GatewayStatus', { default => {'conditions' => [{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Accepted'},{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Programmed'}]} };

=attr spec

Spec defines the desired state of Gateway.

=cut

=attr status

Status defines the current state of Gateway.

=cut

1;
