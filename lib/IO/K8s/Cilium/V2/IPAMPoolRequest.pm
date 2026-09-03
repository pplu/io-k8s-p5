package IO::K8s::Cilium::V2::IPAMPoolRequest;
# ABSTRACT: IPAMPoolRequest
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s needed => '+IO::K8s::Cilium::V2::IPAMPoolDemand';
k8s pool   => Str, { required => 'schema' };

=attr needed

Needed indicates how many IPs out of the above Pool this node requests
from the operator. The operator runs a reconciliation loop to ensure each
node always has enough PodCIDRs allocated in each pool to fulfill the
requested number of IPs here.

=cut

=attr pool

Pool is the name of the IPAM pool backing this request

=cut

1;
