package IO::K8s::Cilium::V2alpha1::CiliumGatewayClassConfig;
# ABSTRACT: CiliumGatewayClassConfig is a Kubernetes third-party resource which is used to configure Gateways owned by GatewayClass.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumgatewayclassconfigs';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::Cilium::V2alpha1::CiliumGatewayClassConfigSpec';
k8s status => '+IO::K8s::Cilium::V2alpha1::CiliumGatewayClassConfigStatus';

=attr spec

Spec is a human-readable of a GatewayClass configuration.

=cut

=attr status

Status is the status of the policy.

=cut

1;
