package IO::K8s::Cilium::V2::CiliumBGPNodeConfig;
# ABSTRACT: CiliumBGPNodeConfig is node local configuration for BGP agent.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumbgpnodeconfigs';

k8s spec   => '+IO::K8s::Cilium::V2::CiliumBGPNodeSpec', { required => 'schema' };
k8s status => '+IO::K8s::Cilium::V2::CiliumBGPNodeStatus';

=attr spec

Spec is the specification of the desired behavior of the CiliumBGPNodeConfig.

=cut

=attr status

Status is the most recently observed status of the CiliumBGPNodeConfig.

=cut

1;
