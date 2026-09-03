package IO::K8s::Cilium::V2::CiliumBGPNodeStatus;
# ABSTRACT: Status is the most recently observed status of the CiliumBGPNodeConfig.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s bgpInstances => ['+IO::K8s::Cilium::V2::CiliumBGPNodeInstanceStatus'];
k8s conditions   => ['Meta::V1::Condition'];

=attr bgpInstances

BGPInstances is the status of the BGP instances on the node.

=cut

=attr conditions

The current conditions of the CiliumBGPNodeConfig

=cut

1;
