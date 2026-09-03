package IO::K8s::Cilium::V2alpha1::CiliumBGPPeerConfigSpec;
# ABSTRACT: Spec is the specification of the desired behavior of the CiliumBGPPeerConfig.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authSecretRef   => Str;
k8s ebgpMultihop    => Int, { minimum => 1, maximum => 255, default => 1 };
k8s families        => ['+IO::K8s::Cilium::V2alpha1::CiliumBGPFamilyWithAdverts'];
k8s gracefulRestart => '+IO::K8s::Cilium::V2alpha1::CiliumBGPNeighborGracefulRestart';
k8s timers          => '+IO::K8s::Cilium::V2alpha1::CiliumBGPTimers';
k8s transport       => '+IO::K8s::Cilium::V2alpha1::CiliumBGPTransport';

=attr authSecretRef

AuthSecretRef is the name of the secret to use to fetch a TCP
authentication password for this peer.

If not specified, no authentication is used.

=cut

=attr ebgpMultihop

EBGPMultihopTTL controls the multi-hop feature for eBGP peers.
Its value defines the Time To Live (TTL) value used in BGP
packets sent to the peer.

If not specified, EBGP multihop is disabled. This field is ignored for iBGP neighbors.

=cut

=attr families

Families, if provided, defines a set of AFI/SAFIs the speaker will
negotiate with it's peer.

If not specified, the default families of IPv6/unicast and IPv4/unicast will be created.

=cut

=attr gracefulRestart

GracefulRestart defines graceful restart parameters which are negotiated
with this peer.

If not specified, the graceful restart capability is disabled.

=cut

=attr timers

Timers defines the BGP timers for the peer.

If not specified, the default timers are used.

=cut

=attr transport

Transport defines the BGP transport parameters for the peer.

If not specified, the default transport parameters are used.

=cut

1;
