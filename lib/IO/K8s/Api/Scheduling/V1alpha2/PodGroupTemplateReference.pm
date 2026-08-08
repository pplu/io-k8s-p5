package IO::K8s::Api::Scheduling::V1alpha2::PodGroupTemplateReference;
# ABSTRACT: PodGroupTemplateReference references a PodGroup template defined in some object (e.g. Workload). Exactly one reference must be set.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s workload => 'Scheduling::V1alpha2::WorkloadPodGroupTemplateReference';

=attr workload

Workload references the PodGroupTemplate within the Workload object that was used to create the PodGroup.

=cut

1;
