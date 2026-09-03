package IO::K8s::Cilium::V2::IPAMPoolDemand;
# ABSTRACT: Needed indicates how many IPs out of the above Pool this node requests from the operator.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'ipv4-addrs' => Int;
k8s 'ipv6-addrs' => Int;

=attr ipv4-addrs

IPv4Addrs contains the number of requested IPv4 addresses out of a given
pool

=cut

=attr ipv6-addrs

IPv6Addrs contains the number of requested IPv6 addresses out of a given
pool

=cut

1;
