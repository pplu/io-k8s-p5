package IO::K8s::Cilium::V2::PeerConfigReference;
# ABSTRACT: PeerConfigRef is a reference to a peer configuration resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, { required => 'schema' };

=attr name

Name is the name of the peer config resource.
Name refers to the name of a Kubernetes object (typically a CiliumBGPPeerConfig).

=cut

1;
