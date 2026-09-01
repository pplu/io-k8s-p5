package IO::K8s::Api::Scheduling::V1beta1::CompositePodGroupTemplate;
# ABSTRACT: CompositePodGroupTemplate represents a template for a CompositePodGroup with a scheduling policy.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s compositePodGroupTemplates => ['Scheduling::V1beta1::CompositePodGroupTemplate'];

=attr compositePodGroupTemplates

compositePodGroupTemplates is the list of templates for children CompositePodGroups. The maximum number of templates is 8. At least one entry in CompositePodGroupTemplates or PodGroupTemplates must be set.

=cut

k8s disruptionMode => 'Scheduling::V1beta1::CompositeDisruptionMode';

=attr disruptionMode

disruptionMode defines the mode in which a given CompositePodGroup can be disrupted. One of Single, All. This field is immutable.

=cut

k8s name => Str, 'required';

=attr name

name is a unique identifier for the CompositePodGroupTemplate within the Workload. It must be a DNS label. This field is required.

=cut

k8s podGroupTemplates => ['Scheduling::V1beta1::PodGroupTemplate'];

=attr podGroupTemplates

podGroupTemplates is the list of templates for children PodGroups. The maximum number of templates is 8. At least one entry in CompositePodGroupTemplates or PodGroupTemplates must be set.

=cut

k8s preemptionPolicy => Str;

=attr preemptionPolicy

preemptionPolicy is the Policy for preempting pods/podgroups with lower priority. One of Never, PreemptLowerPriority. This field is immutable. This field is available only when the PodGroupPreemptionPolicy feature gate is enabled.

=cut

k8s priority => Int;

=attr priority

priority is the value of priority of composite pod groups created from this template. Various system components use this field to find the priority of the composite pod group. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority. This field is immutable.

=cut

k8s priorityClassName => Str;

=attr priorityClassName

priorityClassName indicates the priority that should be considered when scheduling a composite pod group created from this template. If no priority class is specified, admission control can set this to the global default priority class if it exists. Otherwise, composite pod groups created from this template will have the priority set to zero. This field is immutable.

=cut

k8s schedulingConstraints => 'Scheduling::V1beta1::CompositePodGroupSchedulingConstraints';

=attr schedulingConstraints

schedulingConstraints defines optional scheduling constraints (e.g. topology) for this CompositePodGroupTemplate. This field is immutable.

=cut

k8s schedulingPolicy => 'Scheduling::V1beta1::CompositePodGroupSchedulingPolicy', 'required';

=attr schedulingPolicy

schedulingPolicy defines the scheduling policy for this template.

=cut

1;
