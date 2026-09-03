package IO::K8s::Cilium::V2::CiliumLoadBalancerIPPoolSpec;
# ABSTRACT: Spec is a human readable description for a BGP load balancer ip pool.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allowFirstLastIPs => Str, { enum => [qw(Yes No)] };
k8s blocks            => ['+IO::K8s::Cilium::V2::CiliumLoadBalancerIPPoolIPBlock'];
k8s disabled          => Bool, { default => 0 };
k8s serviceSelector   => 'Meta::V1::LabelSelector';

=attr allowFirstLastIPs

AllowFirstLastIPs, if set to `Yes` or undefined means that the first and last IPs of each CIDR will be allocatable.
If `No`, these IPs will be reserved. This field is ignored for /{31,32} and /{127,128} CIDRs since
reserving the first and last IPs would make the CIDRs unusable.

=cut

=attr blocks

Blocks is a list of CIDRs comprising this IP Pool

=cut

=attr disabled

Disabled, if set to true means that no new IPs will be allocated from this pool.
Existing allocations will not be removed from services.

=cut

=attr serviceSelector

ServiceSelector selects a set of services which are eligible to receive IPs from this

=cut

1;
