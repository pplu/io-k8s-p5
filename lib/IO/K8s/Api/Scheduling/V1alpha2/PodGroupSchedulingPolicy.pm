package IO::K8s::Api::Scheduling::V1alpha2::PodGroupSchedulingPolicy;
# ABSTRACT: PodGroupSchedulingPolicy defines the scheduling configuration for a PodGroup. Exactly one policy must be set.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s basic => 'Scheduling::V1alpha2::BasicSchedulingPolicy';

=attr basic

Basic specifies that the pods in this group should be scheduled using standard Kubernetes scheduling behavior.

=cut

k8s gang => 'Scheduling::V1alpha2::GangSchedulingPolicy';

=attr gang

Gang specifies that the pods in this group should be scheduled using all-or-nothing semantics.

=cut

1;
