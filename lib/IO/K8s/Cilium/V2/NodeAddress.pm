package IO::K8s::Cilium::V2::NodeAddress;
# ABSTRACT: NodeAddress is a node address.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ip   => Str;
k8s type => Str;

=attr ip

IP is an IP of a node

=cut

=attr type

Type is the type of the node address

=cut

1;
