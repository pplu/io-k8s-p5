package IO::K8s::Cilium::V2::CiliumLoadBalancerIPPoolIPBlock;
# ABSTRACT: CiliumLoadBalancerIPPoolIPBlock describes a single IP block.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cidr  => Str;
k8s start => Str;
k8s stop  => Str;

=attr cidr

No description in the upstream schema.

=cut

=attr start

No description in the upstream schema.

=cut

=attr stop

No description in the upstream schema.

=cut

1;
