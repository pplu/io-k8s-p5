package IO::K8s::GatewayAPI::V1::ReferenceGrant;
# ABSTRACT: ReferenceGrant identifies kinds of resources in other namespaces that are trusted to reference the specified kinds of resources in the same namespace as the policy.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'referencegrants';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::GatewayAPI::V1::ReferenceGrantSpec', { required => 'schema' };

=attr spec

Spec defines the desired state of ReferenceGrant.

=cut

1;
