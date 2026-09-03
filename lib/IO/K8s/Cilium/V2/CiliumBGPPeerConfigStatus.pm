package IO::K8s::Cilium::V2::CiliumBGPPeerConfigStatus;
# ABSTRACT: Status is the running status of the CiliumBGPPeerConfig
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

The current conditions of the CiliumBGPPeerConfig

=cut

1;
