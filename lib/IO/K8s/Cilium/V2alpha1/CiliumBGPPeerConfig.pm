package IO::K8s::Cilium::V2alpha1::CiliumBGPPeerConfig;
# ABSTRACT: CiliumBGPPeerConfig
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumbgppeerconfigs';

k8s spec   => '+IO::K8s::Cilium::V2alpha1::CiliumBGPPeerConfigSpec', { required => 'schema' };
k8s status => '+IO::K8s::Cilium::V2alpha1::CiliumBGPPeerConfigStatus';

=attr spec

Spec is the specification of the desired behavior of the CiliumBGPPeerConfig.

=cut

=attr status

Status is the running status of the CiliumBGPPeerConfig

=cut

1;
