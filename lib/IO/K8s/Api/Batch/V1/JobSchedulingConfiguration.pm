package IO::K8s::Api::Batch::V1::JobSchedulingConfiguration;
# ABSTRACT: JobSchedulingConfiguration composes the reusable workload-aware scheduling building blocks.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s disruptionMode => 'Scheduling::V1alpha3::WorkloadPodGroupDisruptionMode';

=attr disruptionMode

DisruptionMode defines the mode in which the Job's pods can be disrupted. One of Single, All. This field is immutable after creation: it may not be added or removed, and the selected mode may not be changed.

=cut

k8s resourceClaims => ['Scheduling::V1alpha3::WorkloadPodGroupResourceClaim'];

=attr resourceClaims

ResourceClaims defines which ResourceClaims may be shared among Pods in the Job. Pods consume the devices allocated to a PodGroup's claim by defining a claim in its own Spec.ResourceClaims that matches the PodGroup's claim exactly. The claim must have the same name and refer to the same ResourceClaim or ResourceClaimTemplate. At most 4 claims may be set, matching the limit on the resulting PodGroup. This list is immutable after creation: entries may neither be added, removed, nor modified.

=cut

k8s schedulingConstraints => 'Scheduling::V1alpha3::WorkloadPodGroupSchedulingConstraints';

=attr schedulingConstraints

SchedulingConstraints defines scheduling constraints (e.g. topology) for the Job's pods. This field is immutable after creation.

=cut

k8s schedulingPolicy => 'Scheduling::V1alpha3::WorkloadPodGroupSchedulingPolicy';

=attr schedulingPolicy

SchedulingPolicy defines the scheduling policy for this Job. Exactly one of Basic or Gang must be set. This field is immutable after creation: the policy may not be added or removed. The policy variant (basic/gang) is frozen by hand-written validation; only schedulingPolicy.gang.minCount may be changed.

=cut

1;
