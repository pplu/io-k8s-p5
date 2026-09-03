package IO::K8s::Cilium::V2::BGPFamilyRouteCount;
# ABSTRACT: BGPFamilyRouteCount
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s advertised => Int;
k8s afi        => Str, { required => 'schema', enum => [qw(ipv4 ipv6 l2vpn ls opaque)] };
k8s received   => Int;
k8s safi       => Str, { required => 'schema', enum => [qw(unicast multicast mpls_label encapsulation vpls evpn ls sr_policy mup mpls_vpn mpls_vpn_multicast route_target_constraints flowspec_unicast flowspec_vpn key_value)] };

=attr advertised

Advertised is the number of routes advertised to this peer.

=cut

=attr afi

Afi is the Address Family Identifier (AFI) of the family.

=cut

=attr received

Received is the number of routes received from this peer.

=cut

=attr safi

Safi is the Subsequent Address Family Identifier (SAFI) of the family.

=cut

1;
