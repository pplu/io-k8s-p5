package IO::K8s::Cilium::V2::EgressDenyRule;
# ABSTRACT: EgressDenyRule contains all rule types which can be applied at egress, i.e.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s icmps       => ['+IO::K8s::Cilium::V2::ICMPRule'];
k8s toCIDR      => [Str];
k8s toCIDRSet   => ['+IO::K8s::Cilium::V2::CIDRRule'];
k8s toEndpoints => ['Meta::V1::LabelSelector'];
k8s toEntities  => [Str], { enum => [qw(all world cluster cluster-mesh host init ingress unmanaged remote-node health none kube-apiserver)] };
k8s toGroups    => ['+IO::K8s::Cilium::V2::Groups'];
k8s toNodes     => ['Meta::V1::LabelSelector'];
k8s toPorts     => ['+IO::K8s::Cilium::V2::PortDenyRule'];
k8s toRequires  => [Str];
k8s toServices  => ['+IO::K8s::Cilium::V2::Service'];

=attr icmps

ICMPs is a list of ICMP rule identified by type number
which the endpoint subject to the rule is not allowed to connect to.

Example:
Any endpoint with the label "app=httpd" is not allowed to initiate
type 8 ICMP connections.

=cut

=attr toCIDR

ToCIDR is a list of IP blocks which the endpoint subject to the rule
is allowed to initiate connections. Only connections destined for
outside of the cluster and not targeting the host will be subject
to CIDR rules.  This will match on the destination IP address of
outgoing connections. Adding a prefix into ToCIDR or into ToCIDRSet
with no ExcludeCIDRs is equivalent. Overlaps are allowed between
ToCIDR and ToCIDRSet.

Example:
Any endpoint with the label "app=database-proxy" is allowed to
initiate connections to 10.2.3.0/24

=cut

=attr toCIDRSet

ToCIDRSet is a list of IP blocks which the endpoint subject to the rule
is allowed to initiate connections to in addition to connections
which are allowed via ToEndpoints, along with a list of subnets contained
within their corresponding IP block to which traffic should not be
allowed. This will match on the destination IP address of outgoing
connections. Adding a prefix into ToCIDR or into ToCIDRSet with no
ExcludeCIDRs is equivalent. Overlaps are allowed between ToCIDR and
ToCIDRSet.

Example:
Any endpoint with the label "app=database-proxy" is allowed to
initiate connections to 10.2.3.0/24 except from IPs in subnet 10.2.3.0/28.

=cut

=attr toEndpoints

ToEndpoints is a list of endpoints identified by an EndpointSelector to
which the endpoints subject to the rule are allowed to communicate.

Example:
Any endpoint with the label "role=frontend" can communicate with any
endpoint carrying the label "role=backend".

Note that while an empty non-nil ToEndpoints does not select anything,
nil ToEndpoints is implicitly treated as a wildcard selector if ToPorts
are also specified.
To select everything, use one EndpointSelector without any match requirements.

=cut

=attr toEntities

ToEntities is a list of special entities to which the endpoint subject
to the rule is allowed to initiate connections. Supported entities are
`world`, `cluster`, `cluster-mesh`, `host`, `remote-node`, `kube-apiserver`, `ingress`, `init`,
`health`, `unmanaged`, `none` and `all`.

=cut

=attr toGroups

ToGroups allows policies to reference CIDRs provided by external integrations.
Currently, only AWS is supported, and the rule can select by multiple sub directives.
ToGroups entries are functionally equivalent to toCIDR, and have the same
limitiations. They cannot select traffic originating from within the cluster.

Example:
toGroups:
- aws:
    securityGroupsIds:
    - 'sg-XXXXXXXXXXXXX'

=cut

=attr toNodes

ToNodes is a list of nodes identified by an
EndpointSelector to which endpoints subject to the rule is allowed to communicate.

=cut

=attr toPorts

ToPorts is a list of destination ports identified by port number and
protocol which the endpoint subject to the rule is not allowed to connect
to.

Example:
Any endpoint with the label "role=frontend" is not allowed to initiate
connections to destination port 8080/tcp

=cut

=attr toRequires

Deprecated.

=cut

=attr toServices

ToServices is a list of services to which the endpoint subject
to the rule is allowed to initiate connections.
Currently Cilium only supports toServices for K8s services.

=cut

1;
