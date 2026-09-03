package IO::K8s::Cilium::V2::IPAMPoolSpec;
# ABSTRACT: Pools contains the list of assigned IPAM pools for this node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allocated => ['+IO::K8s::Cilium::V2::IPAMPoolAllocation'];
k8s requested => ['+IO::K8s::Cilium::V2::IPAMPoolRequest'];

=attr allocated

Allocated contains the list of pooled CIDR assigned to this node. The
operator will add new pod CIDRs to this field, whereas the agent will
remove CIDRs it has released.

=cut

=attr requested

Requested contains a list of IPAM pool requests, i.e. indicates how many
addresses this node requests out of each pool listed here. This field
is owned and written to by cilium-agent and read by the operator.

=cut

1;
