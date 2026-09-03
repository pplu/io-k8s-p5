package IO::K8s::Cilium::V2::AwsVPC;
# ABSTRACT: VPC is the VPC information to which the ENI is attached to
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cidrs          => [Str];
k8s id             => Str;
k8s 'primary-cidr' => Str;

=attr cidrs

CIDRs is the list of CIDR ranges associated with the VPC

=cut

=attr id

/ ID is the ID of a VPC

=cut

=attr primary-cidr

PrimaryCIDR is the primary CIDR of the VPC

=cut

1;
