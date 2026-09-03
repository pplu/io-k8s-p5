package IO::K8s::Cilium::V2::HealthAddressingSpec;
# ABSTRACT: HealthAddressing is the addressing information for health connectivity checking.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ipv4 => Str;
k8s ipv6 => Str;

=attr ipv4

IPv4 is the IPv4 address of the IPv4 health endpoint.

=cut

=attr ipv6

IPv6 is the IPv6 address of the IPv4 health endpoint.

=cut

1;
