package IO::K8s::Cilium::V2::VPC;
# ABSTRACT: VPC is the vpc to which the ENI belongs
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cidr              => Str;
k8s 'ipv6-cidr'       => Str;
k8s 'secondary-cidrs' => [Str];
k8s 'vpc-id'          => Str;

=attr cidr

CIDRBlock is the VPC IPv4 CIDR

=cut

=attr ipv6-cidr

IPv6CIDRBlock is the VPC IPv6 CIDR

=cut

=attr secondary-cidrs

SecondaryCIDRs is the list of Secondary CIDRs associated with the VPC

=cut

=attr vpc-id

VPCID is the vpc to which the ENI belongs

=cut

1;
