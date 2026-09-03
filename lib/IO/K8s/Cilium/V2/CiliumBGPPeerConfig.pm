package IO::K8s::Cilium::V2::CiliumBGPPeerConfig;
# ABSTRACT: CiliumBGPPeerConfig
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumbgppeerconfigs';

k8s spec   => '+IO::K8s::Cilium::V2::CiliumBGPPeerConfigSpec', { required => 'schema' };
k8s status => '+IO::K8s::Cilium::V2::CiliumBGPPeerConfigStatus';

=attr spec

Spec is the specification of the desired behavior of the CiliumBGPPeerConfig.

=cut

=attr status

Status is the running status of the CiliumBGPPeerConfig

=cut

1;
