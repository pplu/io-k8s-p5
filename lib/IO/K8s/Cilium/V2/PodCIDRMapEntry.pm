package IO::K8s::Cilium::V2::PodCIDRMapEntry;
# ABSTRACT: PodCIDRMapEntry
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s status => Str, { enum => [qw(released depleted in-use)] };

=attr status

Status describes the status of a pod CIDR

=cut

1;
