package IO::K8s::GatewayAPI::V1::ListenerSet;
# ABSTRACT: ListenerSet defines a set of additional listeners to attach to an existing Gateway.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'listenersets';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::GatewayAPI::V1::ListenerSetSpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1::ListenerSetStatus', { default => {'conditions' => [{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Accepted'},{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Programmed'}]} };

=attr spec

Spec defines the desired state of ListenerSet.

=cut

=attr status

Status defines the current state of ListenerSet.

=cut

1;
