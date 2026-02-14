package IO::K8s::Api::Core::V1::ReplicationController;
# ABSTRACT: ReplicationController represents the configuration of a replication controller.
our $VERSION = '1.002';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

ReplicationController represents the configuration of a replication controller.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Core::V1::ReplicationControllerSpec';

=attr spec

Spec defines the specification of the desired behavior of the replication controller. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

k8s status => 'Core::V1::ReplicationControllerStatus';

=attr status

Status is the most recently observed status of the replication controller. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#replicationcontroller-v1-core>

=cut
1;
