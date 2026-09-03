package IO::K8s::Cilium::V2::CiliumBGPInstance;
# ABSTRACT: CiliumBGPInstance
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s localASN  => Int, { minimum => 1, maximum => 4294967295 };
k8s localPort => Int, { minimum => 1, maximum => 65535 };
k8s name      => Str, { required => 'schema' };
k8s peers     => ['+IO::K8s::Cilium::V2::CiliumBGPPeer'];

=attr localASN

LocalASN is the ASN of this BGP instance.
Supports extended 32bit ASNs.

=cut

=attr localPort

LocalPort is the port on which the BGP daemon listens for incoming connections.

If not specified, BGP instance will not listen for incoming connections.

=cut

=attr name

Name is the name of the BGP instance. It is a unique identifier for the BGP instance
within the cluster configuration.

=cut

=attr peers

Peers is a list of neighboring BGP peers for this virtual router

=cut

1;
