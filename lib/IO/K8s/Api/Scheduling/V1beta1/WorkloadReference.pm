package IO::K8s::Api::Scheduling::V1beta1::WorkloadReference;
# ABSTRACT: WorkloadReference references the Workload object together with the template that was used to create a particular PodGroup.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s templateName => Str, 'required';

=attr templateName

templateName is the name of a template within the Workload object that was used to create a pod group. It must be a DNS label. This field is required.

=cut

k8s workloadName => Str, 'required';

=attr workloadName

workloadName is the name of the Workload object that contains a template that was used when creating a pod group. It must be a DNS name. This field is required.

=cut

1;
