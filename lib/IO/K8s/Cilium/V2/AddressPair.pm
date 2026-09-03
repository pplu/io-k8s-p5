package IO::K8s::Cilium::V2::AddressPair;
# ABSTRACT: IngressAddressing is the addressing information for Ingress listener.
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
