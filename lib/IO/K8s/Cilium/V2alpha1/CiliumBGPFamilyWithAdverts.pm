package IO::K8s::Cilium::V2alpha1::CiliumBGPFamilyWithAdverts;
# ABSTRACT: CiliumBGPFamilyWithAdverts represents a AFI/SAFI address family pair along with reference to BGP Advertisements.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s advertisements => 'Meta::V1::LabelSelector';
k8s afi            => Str, { required => 'schema', enum => [qw(ipv4 ipv6 l2vpn ls opaque)] };
k8s safi           => Str, { required => 'schema', enum => [qw(unicast multicast mpls_label encapsulation vpls evpn ls sr_policy mup mpls_vpn mpls_vpn_multicast route_target_constraints flowspec_unicast flowspec_vpn key_value)] };

=attr advertisements

Advertisements selects group of BGP Advertisement(s) to advertise for this family.

If not specified, no advertisements are sent for this family.

=cut

=attr afi

Afi is the Address Family Identifier (AFI) of the family.

=cut

=attr safi

Safi is the Subsequent Address Family Identifier (SAFI) of the family.

=cut

1;
