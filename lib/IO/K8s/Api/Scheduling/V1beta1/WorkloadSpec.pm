package IO::K8s::Api::Scheduling::V1beta1::WorkloadSpec;
# ABSTRACT: WorkloadSpec defines the desired state of a Workload.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s compositePodGroupTemplates => ['Scheduling::V1beta1::CompositePodGroupTemplate'];

=attr compositePodGroupTemplates

compositePodGroupTemplates is the list of CompositePodGroup templates that make up the Workload. The maximum number of templates is 8. This field is immutable. Exactly one of CompositePodGroupTemplates and PodGroupTemplates must be set.

This field is used only when the CompositePodGroup feature gate is enabled.

=cut

k8s controllerRef => 'Scheduling::V1beta1::TypedLocalObjectReference';

=attr controllerRef

controllerRef is an optional reference to the controlling object, such as a Deployment or Job. This field is intended for use by tools like CLIs to provide a link back to the original workload definition. This field is immutable.

=cut

k8s podGroupTemplates => ['Scheduling::V1beta1::PodGroupTemplate'];

=attr podGroupTemplates

podGroupTemplates is the list of templates that make up the Workload. The maximum number of templates is 8. Templates cannot be added or removed after the workload is created. Existing templates may still be updated where their individual fields allow it. Exactly one of CompositePodGroupTemplates and PodGroupTemplates must be set.

=cut

1;
