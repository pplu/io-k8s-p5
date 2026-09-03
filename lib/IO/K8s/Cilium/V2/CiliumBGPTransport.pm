package IO::K8s::Cilium::V2::CiliumBGPTransport;
# ABSTRACT: Transport defines the BGP transport parameters for the peer.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s peerPort        => Int, { minimum => 1, maximum => 65535, default => 179 };
k8s sourceInterface => Str;

=attr peerPort

PeerPort is the peer port to be used for the BGP session.

If not specified, defaults to TCP port 179.

=cut

=attr sourceInterface

SourceInterface is the name of a local interface, which IP address will be used
as the source IP address for the BGP session. The interface must not have more than one
non-loopback, non-multicast and non-link-local-IPv6 address per address family.

If not specified, or if the provided interface is not found or missing a usable IP address,
the source IP address will be auto-detected based on the egress interface.

=cut

1;
