package IO::K8s::Cilium::V2::VSwitch;
# ABSTRACT: VSwitch is the vSwitch the ENI is using
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cidr         => Str;
k8s 'ipv6-cidr'  => Str;
k8s 'vswitch-id' => Str;

=attr cidr

CIDRBlock is the vSwitch IPv4 CIDR

=cut

=attr ipv6-cidr

IPv6CIDRBlock is the vSwitch IPv6 CIDR

=cut

=attr vswitch-id

VSwitchID is the vSwitch to which the ENI belongs

=cut

1;
