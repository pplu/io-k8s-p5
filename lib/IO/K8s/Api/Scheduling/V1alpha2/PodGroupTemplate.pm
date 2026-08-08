package IO::K8s::Api::Scheduling::V1alpha2::PodGroupTemplate;
# ABSTRACT: PodGroupTemplate represents a template for a set of pods with a scheduling policy.
our $VERSION = '1.101';
use IO::K8s::Resource;

k8s disruptionMode => Str;

=attr disruptionMode

DisruptionMode defines the mode in which a given PodGroup can be disrupted. One of Pod, PodGroup. This field is available only when the WorkloadAwarePreemption feature gate is enabled.

Possible enum values:

=over 4

=item * C<"Pod"> means that individual pods can be disrupted or preempted independently. It doesn't depend on exact set of pods currently running in this PodGroup.

=item * C<"PodGroup"> means that the whole PodGroup needs to be disrupted or preempted together.

=back

=cut

k8s name => Str, 'required';

=attr name

Name is a unique identifier for the PodGroupTemplate within the Workload. It must be a DNS label. This field is immutable.

=cut

k8s priority => Int;

=attr priority

Priority is the value of priority of pod groups created from this template. Various system components use this field to find the priority of the pod group. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority. This field is available only when the WorkloadAwarePreemption feature gate is enabled.

=cut

k8s priorityClassName => Str;

=attr priorityClassName

PriorityClassName indicates the priority that should be considered when scheduling a pod group created from this template. If no priority class is specified, admission control can set this to the global default priority class if it exists. Otherwise, pod groups created from this template will have the priority set to zero. This field is available only when the WorkloadAwarePreemption feature gate is enabled.

=cut

k8s resourceClaims => ['Scheduling::V1alpha2::PodGroupResourceClaim'];

=attr resourceClaims

ResourceClaims defines which ResourceClaims may be shared among Pods in the group. Pods consume the devices allocated to a PodGroup's claim by defining a claim in its own Spec.ResourceClaims that matches the PodGroup's claim exactly. The claim must have the same name and refer to the same ResourceClaim or ResourceClaimTemplate.

This is an alpha-level field and requires that the DRAWorkloadResourceClaims feature gate is enabled.

This field is immutable.

=cut

k8s schedulingConstraints => 'Scheduling::V1alpha2::PodGroupSchedulingConstraints';

=attr schedulingConstraints

SchedulingConstraints defines optional scheduling constraints (e.g. topology) for this PodGroupTemplate. This field is only available when the TopologyAwareWorkloadScheduling feature gate is enabled.

=cut

k8s schedulingPolicy => 'Scheduling::V1alpha2::PodGroupSchedulingPolicy', 'required';

=attr schedulingPolicy

SchedulingPolicy defines the scheduling policy for this PodGroupTemplate.

=cut

1;
