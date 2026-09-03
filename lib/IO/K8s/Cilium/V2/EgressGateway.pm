package IO::K8s::Cilium::V2::EgressGateway;
# ABSTRACT: EgressGateway identifies the node that should act as egress gateway for a given egress Gateway policy.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s egressIP     => Str;
k8s interface    => Str;
k8s nodeSelector => 'Meta::V1::LabelSelector', { required => 'schema' };

=attr egressIP

EgressIP is the source IP address that the egress traffic is SNATed
with.

Example:
When set to "192.168.1.100", matching egress traffic will be
redirected to the node matching the NodeSelector field and SNATed
with IP address 192.168.1.100.

When set to "2001:db8::1", matching egress traffic will be
redirected to the node matching the NodeSelector field and SNATed
with IPv6 address 2001:db8::1.

When none of the Interface or EgressIP fields is specified, the
policy will use the first IPv4 assigned to the interface with the
default route.

=cut

=attr interface

Interface is the network interface to which the egress IP address
that the traffic is SNATed with is assigned.

Example:
When set to "eth1", matching egress traffic will be redirected to the
node matching the NodeSelector field and SNATed with the first IPv4
address assigned to the eth1 interface.

When none of the Interface or EgressIP fields is specified, the
policy will use the first IPv4 assigned to the interface with the
default route.

=cut

=attr nodeSelector

This is a label selector which selects the node that should act as
egress gateway for the given policy.
In case multiple nodes are selected, only the first one in the
lexical ordering over the node names will be used.
This field follows standard label selector semantics.

=cut

1;
