package IO::K8s::Api::Scheduling::V1alpha3::Workload;
# ABSTRACT: Workload allows for expressing scheduling constraints that should be used when managing the lifecycle of workloads from the scheduling perspective, including scheduling, preemption, eviction and other phases. Workload API enablement is toggled by the GenericWorkload feature gate.
our $VERSION = '1.108';
use IO::K8s::APIObject;

=description

Workload allows for expressing scheduling constraints that should be used when managing the lifecycle of workloads from the scheduling perspective, including scheduling, preemption, eviction and other phases. Workload API enablement is toggled by the GenericWorkload feature gate.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Scheduling::V1alpha3::WorkloadSpec', 'required';

=attr spec

spec defines the desired behavior of a Workload.

=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#workload-v1alpha3-scheduling.k8s.io>


=cut
1;
