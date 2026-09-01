package IO::K8s::Api::Scheduling::V1beta1::PodGroup;
# ABSTRACT: PodGroup represents a runtime instance of pods grouped together. PodGroups are created by workload controllers (Job, LWS, JobSet, etc...) from Workload.podGroupTemplates. PodGroup API enablement is toggled by the GenericWorkload feature gate.
our $VERSION = '1.108';
use IO::K8s::APIObject;

=description

PodGroup represents a runtime instance of pods grouped together. PodGroups are created by workload controllers (Job, LWS, JobSet, etc...) from Workload.podGroupTemplates. PodGroup API enablement is toggled by the GenericWorkload feature gate.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Scheduling::V1beta1::PodGroupSpec', 'required';

=attr spec

spec defines the desired state of the PodGroup.

=cut

k8s status => 'Scheduling::V1beta1::PodGroupStatus';

=attr status

status represents the current observed state of the PodGroup.

=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#podgroup-v1beta1-scheduling.k8s.io>


=cut
1;
