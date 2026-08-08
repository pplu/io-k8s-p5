package IO::K8s::Api::Core::V1::PodSchedulingGroup;
# ABSTRACT: PodSchedulingGroup is used to associate a Pod with the PodGroup runtime instance it belongs to for gang-scheduling purposes.
our $VERSION = '1.105';
use IO::K8s::Resource;

k8s podGroupName => Str, 'required';

=attr podGroupName

PodGroupName is the name of a PodGroup object in the scheduling.k8s.io group that this pod belongs to for gang-scheduling purposes. The PodGroup must exist in the same namespace as this pod.

=cut

1;
