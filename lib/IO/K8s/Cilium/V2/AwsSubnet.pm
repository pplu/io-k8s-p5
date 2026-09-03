package IO::K8s::Cilium::V2::AwsSubnet;
# ABSTRACT: Subnet is the subnet the ENI is associated with
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cidr => Str;
k8s id   => Str;

=attr cidr

CIDR is the CIDR range associated with the subnet

=cut

=attr id

ID is the ID of the subnet

=cut

1;
