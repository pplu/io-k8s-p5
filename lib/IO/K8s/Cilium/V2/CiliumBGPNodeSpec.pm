package IO::K8s::Cilium::V2::CiliumBGPNodeSpec;
# ABSTRACT: Spec is the specification of the desired behavior of the CiliumBGPNodeConfig.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s bgpInstances => ['+IO::K8s::Cilium::V2::CiliumBGPNodeInstance'], { required => 'schema' };

=attr bgpInstances

BGPInstances is a list of BGP router instances on the node.

=cut

1;
