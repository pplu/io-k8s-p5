package IO::K8s::Cilium::V2::CiliumBGPClusterConfigStatus;
# ABSTRACT: Status is a running status of the cluster configuration
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

The current conditions of the CiliumBGPClusterConfig

=cut

1;
