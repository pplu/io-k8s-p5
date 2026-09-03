package IO::K8s::Cilium::V2alpha1::CiliumBGPClusterConfigSpec;
# ABSTRACT: Spec defines the desired cluster configuration of the BGP control plane.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s bgpInstances => ['+IO::K8s::Cilium::V2alpha1::CiliumBGPInstance'], { required => 'schema' };
k8s nodeSelector => 'Meta::V1::LabelSelector';

=attr bgpInstances

A list of CiliumBGPInstance(s) which instructs
the BGP control plane how to instantiate virtual BGP routers.

=cut

=attr nodeSelector

NodeSelector selects a group of nodes where this BGP Cluster
config applies.
If empty / nil this config applies to all nodes.

=cut

1;
