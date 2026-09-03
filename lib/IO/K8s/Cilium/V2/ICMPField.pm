package IO::K8s::Cilium::V2::ICMPField;
# ABSTRACT: ICMPField is a ICMP field.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s family => Str, { enum => [qw(IPv4 IPv6)], default => 'IPv4' };
k8s type   => IntOrStr, { required => 'schema', pattern => qr/^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]|EchoReply|DestinationUnreachable|Redirect|Echo|RouterAdvertisement|RouterSelection|TimeExceeded|ParameterProblem|Timestamp|TimestampReply|Photuris|ExtendedEchoRequest|ExtendedEcho Reply|PacketTooBig|ParameterProblem|EchoRequest|MulticastListenerQuery|MulticastListenerReport|MulticastListenerDone|RouterSolicitation|RouterAdvertisement|NeighborSolicitation|NeighborAdvertisement|RedirectMessage|RouterRenumbering|ICMPNodeInformationQuery|ICMPNodeInformationResponse|InverseNeighborDiscoverySolicitation|InverseNeighborDiscoveryAdvertisement|HomeAgentAddressDiscoveryRequest|HomeAgentAddressDiscoveryReply|MobilePrefixSolicitation|MobilePrefixAdvertisement|DuplicateAddressRequestCodeSuffix|DuplicateAddressConfirmationCodeSuffix)$/ };

=attr family

Family is a IP address version.
Currently, we support `IPv4` and `IPv6`.
`IPv4` is set as default.

=cut

=attr type

Type is a ICMP-type.
It should be an 8bit code (0-255), or it's CamelCase name (for example, "EchoReply").
Allowed ICMP types are:
    Ipv4: EchoReply | DestinationUnreachable | Redirect | Echo | EchoRequest |
		     RouterAdvertisement | RouterSelection | TimeExceeded | ParameterProblem |
			 Timestamp | TimestampReply | Photuris | ExtendedEcho Request | ExtendedEcho Reply
    Ipv6: DestinationUnreachable | PacketTooBig | TimeExceeded | ParameterProblem |
			 EchoRequest | EchoReply | MulticastListenerQuery| MulticastListenerReport |
			 MulticastListenerDone | RouterSolicitation | RouterAdvertisement | NeighborSolicitation |
			 NeighborAdvertisement | RedirectMessage | RouterRenumbering | ICMPNodeInformationQuery |
			 ICMPNodeInformationResponse | InverseNeighborDiscoverySolicitation | InverseNeighborDiscoveryAdvertisement |
			 HomeAgentAddressDiscoveryRequest | HomeAgentAddressDiscoveryReply | MobilePrefixSolicitation |
			 MobilePrefixAdvertisement | DuplicateAddressRequestCodeSuffix | DuplicateAddressConfirmationCodeSuffix |
			 ExtendedEchoRequest | ExtendedEchoReply

=cut

1;
