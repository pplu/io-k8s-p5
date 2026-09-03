package IO::K8s::Cilium::V2alpha1::CiliumBGPTransport;
# ABSTRACT: Transport defines the BGP transport parameters for the peer.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s localPort => Int, { minimum => 1, maximum => 65535 };
k8s peerPort  => Int, { minimum => 1, maximum => 65535, default => 179 };

=attr localPort

Deprecated
LocalPort is the local port to be used for the BGP session.

If not specified, ephemeral port will be picked to initiate a connection.

This field is deprecated and will be removed in a future release.
Local port configuration is unnecessary and is not recommended.

=cut

=attr peerPort

PeerPort is the peer port to be used for the BGP session.

If not specified, defaults to TCP port 179.

=cut

1;
