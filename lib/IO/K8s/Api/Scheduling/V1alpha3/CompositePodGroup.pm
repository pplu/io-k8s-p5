package IO::K8s::Api::Scheduling::V1alpha3::CompositePodGroup;
# ABSTRACT: CompositePodGroup represents a runtime instance of pod groups grouped together. CompositePodGroups are created by workload controllers (LWS, JobSet, etc...) from Workload.compositePodGroupTemplates. CompositePodGroup API enablement is toggled by the CompositePodGroup feature gate.
our $VERSION = '1.108';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

CompositePodGroup represents a runtime instance of pod groups grouped together. CompositePodGroups are created by workload controllers (LWS, JobSet, etc...) from Workload.compositePodGroupTemplates. CompositePodGroup API enablement is toggled by the CompositePodGroup feature gate.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Scheduling::V1alpha3::CompositePodGroupSpec', 'required';

=attr spec

spec defines the desired state of the CompositePodGroup.

=cut

k8s status => 'Scheduling::V1alpha3::CompositePodGroupStatus';

=attr status

status represents the current observed state of the CompositePodGroup.

=cut

=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.37/#compositepodgroup-v1alpha3-scheduling.k8s.io>


=cut
1;
