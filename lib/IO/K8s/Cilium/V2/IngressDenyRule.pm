package IO::K8s::Cilium::V2::IngressDenyRule;
# ABSTRACT: IngressDenyRule contains all rule types which can be applied at ingress, i.e.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s fromCIDR      => [Str];
k8s fromCIDRSet   => ['+IO::K8s::Cilium::V2::CIDRRule'];
k8s fromEndpoints => ['Meta::V1::LabelSelector'];
k8s fromEntities  => [Str], { enum => [qw(all world cluster cluster-mesh host init ingress unmanaged remote-node health none kube-apiserver)] };
k8s fromGroups    => ['+IO::K8s::Cilium::V2::Groups'];
k8s fromNodes     => ['Meta::V1::LabelSelector'];
k8s fromRequires  => [Str];
k8s icmps         => ['+IO::K8s::Cilium::V2::ICMPRule'];
k8s toPorts       => ['+IO::K8s::Cilium::V2::PortDenyRule'];

=attr fromCIDR

FromCIDR is a list of IP blocks which the endpoint subject to the
rule is allowed to receive connections from. Only connections which
do *not* originate from the cluster or from the local host are subject
to CIDR rules. In order to allow in-cluster connectivity, use the
FromEndpoints field.  This will match on the source IP address of
incoming connections. Adding  a prefix into FromCIDR or into
FromCIDRSet with no ExcludeCIDRs is  equivalent.  Overlaps are
allowed between FromCIDR and FromCIDRSet.

Example:
Any endpoint with the label "app=my-legacy-pet" is allowed to receive
connections from 10.3.9.1

=cut

=attr fromCIDRSet

FromCIDRSet is a list of IP blocks which the endpoint subject to the
rule is allowed to receive connections from in addition to FromEndpoints,
along with a list of subnets contained within their corresponding IP block
from which traffic should not be allowed.
This will match on the source IP address of incoming connections. Adding
a prefix into FromCIDR or into FromCIDRSet with no ExcludeCIDRs is
equivalent. Overlaps are allowed between FromCIDR and FromCIDRSet.

Example:
Any endpoint with the label "app=my-legacy-pet" is allowed to receive
connections from 10.0.0.0/8 except from IPs in subnet 10.96.0.0/12.

=cut

=attr fromEndpoints

FromEndpoints is a list of endpoints identified by an
EndpointSelector which are allowed to communicate with the endpoint
subject to the rule.

Example:
Any endpoint with the label "role=backend" can be consumed by any
endpoint carrying the label "role=frontend".

Note that while an empty non-nil FromEndpoints does not select anything,
nil FromEndpoints is implicitly treated as a wildcard selector if ToPorts
are also specified.
To select everything, use one EndpointSelector without any match requirements.

=cut

=attr fromEntities

FromEntities is a list of special entities which the endpoint subject
to the rule is allowed to receive connections from. Supported entities are
`world`, `cluster`, `cluster-mesh`, `host`, `remote-node`, `kube-apiserver`, `ingress`, `init`,
`health`, `unmanaged`, `none` and `all`.

=cut

=attr fromGroups

FromGroups allows policies to reference CIDRs provided by external integrations.
Currently, only AWS is supported, and the rule can select by multiple sub directives.
FromGroups entries are functionally equivalent to FromCIDR, and have the same
limitiations. They cannot select traffic originating from within the cluster.

Example:
fromGroups:
- aws:
    securityGroupsIds:
    - 'sg-XXXXXXXXXXXXX'

=cut

=attr fromNodes

FromNodes is a list of nodes identified by an
EndpointSelector which are allowed to communicate with the endpoint
subject to the rule.

=cut

=attr fromRequires

Deprecated.

=cut

=attr icmps

ICMPs is a list of ICMP rule identified by type number
which the endpoint subject to the rule is not allowed to
receive connections on.

Example:
Any endpoint with the label "app=httpd" can not accept incoming
type 8 ICMP connections.

=cut

=attr toPorts

ToPorts is a list of destination ports identified by port number and
protocol which the endpoint subject to the rule is not allowed to
receive connections on.

Example:
Any endpoint with the label "app=httpd" can not accept incoming
connections on port 80/tcp.

=cut

1;
