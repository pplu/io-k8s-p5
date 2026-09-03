package IO::K8s::Cilium::V2::CIDRRule;
# ABSTRACT: CIDRRule is a rule that specifies a CIDR prefix to/from which outside communication is allowed, along with an optional list of subnets within that CIDR prefix to/from which outside communication is not allowed.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cidr              => Str;
k8s cidrGroupRef      => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s cidrGroupSelector => 'Meta::V1::LabelSelector';
k8s except            => [Str];

=attr cidr

CIDR is a CIDR prefix / IP Block.

=cut

=attr cidrGroupRef

CIDRGroupRef is a reference to a CiliumCIDRGroup object.
A CiliumCIDRGroup contains a list of CIDRs that the endpoint, subject to
the rule, can (Ingress/Egress) or cannot (IngressDeny/EgressDeny) receive
connections from.

=cut

=attr cidrGroupSelector

CIDRGroupSelector selects CiliumCIDRGroups by their labels,
rather than by name.

=cut

=attr except

ExceptCIDRs is a list of IP blocks which the endpoint subject to the rule
is not allowed to initiate connections to. These CIDR prefixes should be
contained within Cidr, using ExceptCIDRs together with CIDRGroupRef is not
supported yet.
These exceptions are only applied to the Cidr in this CIDRRule, and do not
apply to any other CIDR prefixes in any other CIDRRules.

=cut

1;
