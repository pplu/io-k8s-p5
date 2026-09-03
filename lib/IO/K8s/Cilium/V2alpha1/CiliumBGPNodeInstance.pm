package IO::K8s::Cilium::V2alpha1::CiliumBGPNodeInstance;
# ABSTRACT: CiliumBGPNodeInstance is a single BGP router instance configuration on the node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s localASN  => Int, { minimum => 1, maximum => 4294967295 };
k8s localPort => Int, { minimum => 1, maximum => 65535 };
k8s name      => Str, { required => 'schema' };
k8s peers     => ['+IO::K8s::Cilium::V2alpha1::CiliumBGPNodePeer'];
k8s routerID  => Str;

=attr localASN

LocalASN is the ASN of this virtual router.
Supports extended 32bit ASNs.

=cut

=attr localPort

LocalPort is the port on which the BGP daemon listens for incoming connections.

If not specified, BGP instance will not listen for incoming connections.

=cut

=attr name

Name is the name of the BGP instance. This name is used to identify the BGP instance on the node.

=cut

=attr peers

Peers is a list of neighboring BGP peers for this virtual router

=cut

=attr routerID

RouterID is the BGP router ID of this virtual router.
This configuration is derived from CiliumBGPNodeConfigOverride resource.

If not specified, the router ID will be derived from the node local address.

=cut

1;
