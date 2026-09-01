package IO::K8s::Api::Scheduling::V1beta1::PodGroupSpec;
# ABSTRACT: PodGroupSpec defines the desired state of a PodGroup.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s disruptionMode => 'Scheduling::V1beta1::DisruptionMode';

=attr disruptionMode

disruptionMode defines the mode in which a given PodGroup can be disrupted. Controllers are expected to fill this field by copying it from a PodGroupTemplate. One of Single, All. Defaults to Single if unset. This field is immutable.

=cut

k8s parentCompositePodGroupName => Str;

=attr parentCompositePodGroupName

parentCompositePodGroupName contains the name of the parent composite pod group within the same namespace as this pod group. If it's nil, then this pod group is a root of a workload's hierarchy. This field is used only when the CompositePodGroup feature gate is enabled. This field is immutable.

=cut

k8s preemptionPolicy => Str;

=attr preemptionPolicy

preemptionPolicy is the Policy for preempting pods/podgroups with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset. When Priority Admission Controller is enabled, it populates this field from PriorityClassName, and defaults to PreemptLowerPriority if value is unset in PriorityClass. This field is immutable. This field is available only when the PodGroupPreemptionPolicy feature gate is enabled.

=cut

k8s priority => Int;

=attr priority

priority is the value of priority of this pod group. Various system components use this field to find the priority of the pod group. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority. This field is immutable.

=cut

k8s priorityClassName => Str;

=attr priorityClassName

priorityClassName defines the priority that should be considered when scheduling this pod group. Controllers are expected to fill this field by copying it from a PodGroupTemplate. Otherwise, it is validated and resolved similarly to the PriorityClassName on PodGroupTemplate (i.e. if no priority class is specified, admission control can set this to the global default priority class if it exists. Otherwise, the pod group's priority will be zero). This field is immutable.

=cut

k8s resourceClaims => ['Scheduling::V1beta1::PodGroupResourceClaim'];

=attr resourceClaims

resourceClaims defines which ResourceClaims may be shared among Pods in the group. Pods consume the devices allocated to a PodGroup's claim by defining a claim in its own Spec.ResourceClaims that matches the PodGroup's claim exactly. The claim must have the same name and refer to the same ResourceClaim or ResourceClaimTemplate.

This is a beta-level field and requires that the DRAWorkloadResourceClaims feature gate is enabled.

This field is immutable.

=cut

k8s schedulingConstraints => 'Scheduling::V1beta1::PodGroupSchedulingConstraints';

=attr schedulingConstraints

schedulingConstraints defines optional scheduling constraints (e.g. topology) for this PodGroup. Controllers are expected to fill this field by copying it from a PodGroupTemplate. This field is immutable. This field is only available when the TopologyAwareWorkloadScheduling feature gate is enabled.

=cut

k8s schedulingPolicy => 'Scheduling::V1beta1::PodGroupSchedulingPolicy', 'required';

=attr schedulingPolicy

schedulingPolicy defines the scheduling policy for this instance of the PodGroup. Controllers are expected to fill this field by copying it from a PodGroupTemplate.

=cut

k8s workloadRef => 'Scheduling::V1beta1::WorkloadReference';

=attr workloadRef

workloadRef references an optional PodGroup template within the Workload object that was used to create the PodGroup. This field is immutable.

=cut

1;
