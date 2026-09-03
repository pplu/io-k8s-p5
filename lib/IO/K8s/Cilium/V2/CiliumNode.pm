package IO::K8s::Cilium::V2::CiliumNode;
# ABSTRACT: CiliumNode represents a node managed by Cilium.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumnodes';

k8s spec   => '+IO::K8s::Cilium::V2::NodeSpec', { required => 'schema' };
k8s status => '+IO::K8s::Cilium::V2::NodeStatus';

=attr spec

Spec defines the desired specification/configuration of the node.

=cut

=attr status

Status defines the realized specification/configuration and status
of the node.

=cut

1;
