package IO::K8s::Cilium::V2alpha1::IPv4PoolSpec;
# ABSTRACT: IPv4 specifies the IPv4 CIDRs and mask sizes of the pool
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cidrs    => [Str], { required => 'schema' };
k8s maskSize => Int, { required => 'schema', minimum => 1, maximum => 32 };

=attr cidrs

CIDRs is a list of IPv4 CIDRs that are part of the pool.

=cut

=attr maskSize

MaskSize is the mask size of the pool.

=cut

1;
