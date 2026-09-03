package IO::K8s::GatewayAPI::V1::GatewayClass;
# ABSTRACT: GatewayClass describes a class of Gateways available to the user for creating Gateway resources.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'gatewayclasses';

k8s spec   => '+IO::K8s::GatewayAPI::V1::GatewayClassSpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1::GatewayClassStatus', { default => {'conditions' => [{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Accepted'}]} };

=attr spec

Spec defines the desired state of GatewayClass.

=cut

=attr status

Status defines the current state of GatewayClass.

Implementations MUST populate status on all GatewayClass resources which
specify their controller name.

=cut

1;
