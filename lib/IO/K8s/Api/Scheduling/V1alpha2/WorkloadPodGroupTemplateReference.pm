package IO::K8s::Api::Scheduling::V1alpha2::WorkloadPodGroupTemplateReference;
# ABSTRACT: WorkloadPodGroupTemplateReference references the PodGroupTemplate within the Workload object.
our $VERSION = '1.105';
use IO::K8s::Resource;

k8s podGroupTemplateName => Str, 'required';

=attr podGroupTemplateName

PodGroupTemplateName defines the PodGroupTemplate name within the Workload object.

=cut

k8s workloadName => Str, 'required';

=attr workloadName

WorkloadName defines the name of the Workload object.

=cut

1;
