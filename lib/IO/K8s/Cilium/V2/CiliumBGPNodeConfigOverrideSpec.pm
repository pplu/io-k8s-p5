package IO::K8s::Cilium::V2::CiliumBGPNodeConfigOverrideSpec;
# ABSTRACT: Spec is the specification of the desired behavior of the CiliumBGPNodeConfigOverride.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s bgpInstances => ['+IO::K8s::Cilium::V2::CiliumBGPNodeConfigInstanceOverride'], { required => 'schema' };

=attr bgpInstances

BGPInstances is a list of BGP instances to override.

=cut

1;
