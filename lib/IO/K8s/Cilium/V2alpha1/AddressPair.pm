package IO::K8s::Cilium::V2alpha1::AddressPair;
# ABSTRACT: AddressPair is a pair of IPv4 and/or IPv6 address.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ipv4 => Str;
k8s ipv6 => Str;

=attr ipv4

No description in the upstream schema.

=cut

=attr ipv6

No description in the upstream schema.

=cut

1;
