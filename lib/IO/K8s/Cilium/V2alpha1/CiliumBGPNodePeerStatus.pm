package IO::K8s::Cilium::V2alpha1::CiliumBGPNodePeerStatus;
# ABSTRACT: CiliumBGPNodePeerStatus is the status of a BGP peer.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s establishedTime => Str;
k8s name            => Str, { required => 'schema' };
k8s peerASN         => Int;
k8s peerAddress     => Str, { required => 'schema' };
k8s peeringState    => Str;
k8s routeCount      => ['+IO::K8s::Cilium::V2alpha1::BGPFamilyRouteCount'];
k8s timers          => '+IO::K8s::Cilium::V2alpha1::CiliumBGPTimersState';

=attr establishedTime

EstablishedTime is the time when the peering session was established.
It is represented in RFC3339 form and is in UTC.

=cut

=attr name

Name is the name of the BGP peer.

=cut

=attr peerASN

PeerASN is the ASN of the neighbor.

=cut

=attr peerAddress

PeerAddress is the IP address of the neighbor.

=cut

=attr peeringState

PeeringState is last known state of the peering session.

=cut

=attr routeCount

RouteCount is the number of routes exchanged with this peer per AFI/SAFI.

=cut

=attr timers

Timers is the state of the negotiated BGP timers for this peer.

=cut

1;
