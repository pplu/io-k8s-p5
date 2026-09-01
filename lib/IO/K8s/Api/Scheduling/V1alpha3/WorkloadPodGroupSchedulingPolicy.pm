package IO::K8s::Api::Scheduling::V1alpha3::WorkloadPodGroupSchedulingPolicy;
# ABSTRACT: WorkloadPodGroupSchedulingPolicy defines the scheduling policy for a group of pods managed by a workload controller. Exactly one policy must be set.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s basic => 'Scheduling::V1alpha3::WorkloadPodGroupBasicSchedulingPolicy';

=attr basic

basic specifies that standard, pod-by-pod Kubernetes scheduling behavior should be used.

=cut

k8s gang => 'Scheduling::V1alpha3::WorkloadPodGroupGangSchedulingPolicy';

=attr gang

gang specifies all-or-nothing scheduling semantics.

=cut

1;
