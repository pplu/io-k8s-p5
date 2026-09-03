package IO::K8s::Cilium::V2alpha1::PeerConfigReference;
# ABSTRACT: PeerConfigRef is a reference to a peer configuration resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group => Str, { default => 'cilium.io' };
k8s kind  => Str, { default => 'CiliumBGPPeerConfig' };
k8s name  => Str, { required => 'schema' };

=attr group

Group is the group of the peer config resource.
If not specified, the default of "cilium.io" is used.

=cut

=attr kind

Kind is the kind of the peer config resource.
If not specified, the default of "CiliumBGPPeerConfig" is used.

=cut

=attr name

Name is the name of the peer config resource.
Name refers to the name of a Kubernetes object (typically a CiliumBGPPeerConfig).

=cut

1;
