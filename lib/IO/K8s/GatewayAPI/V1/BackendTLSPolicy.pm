package IO::K8s::GatewayAPI::V1::BackendTLSPolicy;
# ABSTRACT: BackendTLSPolicy provides a way to configure how a Gateway connects to a Backend via TLS.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'backendtlspolicies';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::GatewayAPI::V1::BackendTLSPolicySpec', { required => 'schema' };
k8s status => '+IO::K8s::GatewayAPI::V1::PolicyStatus';

=attr spec

Spec defines the desired state of BackendTLSPolicy.

=cut

=attr status

Status defines the current state of BackendTLSPolicy.

=cut

1;
