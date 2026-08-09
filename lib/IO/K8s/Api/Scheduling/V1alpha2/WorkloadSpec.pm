package IO::K8s::Api::Scheduling::V1alpha2::WorkloadSpec;
# ABSTRACT: WorkloadSpec defines the desired state of a Workload.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s controllerRef => 'Scheduling::V1alpha2::TypedLocalObjectReference';

=attr controllerRef

ControllerRef is an optional reference to the controlling object, such as a Deployment or Job. This field is intended for use by tools like CLIs to provide a link back to the original workload definition.

This field is immutable.

=cut

k8s podGroupTemplates => ['Scheduling::V1alpha2::PodGroupTemplate'], 'required';

=attr podGroupTemplates

PodGroupTemplates is the list of templates that make up the Workload. The maximum number of templates is 8. This field is immutable.

=cut

1;
