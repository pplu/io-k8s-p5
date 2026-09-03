package IO::K8s::Cilium::V2::IPAMPoolAllocation;
# ABSTRACT: IPAMPoolAllocation describes an allocation of an IPAM pool from the operator to the node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allowFirstIP => Bool;
k8s allowLastIP  => Bool;
k8s cidrs        => [Str];
k8s pool         => Str, { required => 'schema' };

=attr allowFirstIP

AllowFirstIP allows the first IP of each allocated CIDR to be used.

=cut

=attr allowLastIP

AllowLastIP allows the last IP of each allocated CIDR to be used.

=cut

=attr cidrs

CIDRs contains a list of pod CIDRs currently allocated from this pool

=cut

=attr pool

Pool is the name of the IPAM pool backing this allocation

=cut

1;
