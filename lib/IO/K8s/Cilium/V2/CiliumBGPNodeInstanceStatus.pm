package IO::K8s::Cilium::V2::CiliumBGPNodeInstanceStatus;
# ABSTRACT: CiliumBGPNodeInstanceStatus
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s localASN => Int;
k8s name     => Str, { required => 'schema' };
k8s peers    => ['+IO::K8s::Cilium::V2::CiliumBGPNodePeerStatus'];

=attr localASN

LocalASN is the ASN of this BGP instance.

=cut

=attr name

Name is the name of the BGP instance. This name is used to identify the BGP instance on the node.

=cut

=attr peers

PeerStatuses is the state of the BGP peers for this BGP instance.

=cut

1;
