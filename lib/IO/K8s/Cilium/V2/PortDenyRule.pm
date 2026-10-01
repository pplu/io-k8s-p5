package IO::K8s::Cilium::V2::PortDenyRule;
# ABSTRACT: PortDenyRule is a list of ports/protocol that should be used for deny policies.
our $VERSION = '1.110';
use IO::K8s::Resource;

k8s ports => ['+IO::K8s::Cilium::V2::PortProtocol'];

=attr ports

Ports is a list of L4 port/protocol

=cut

1;
