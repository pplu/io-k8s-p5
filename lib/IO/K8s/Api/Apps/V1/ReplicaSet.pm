package IO::K8s::Api::Apps::V1::ReplicaSet;
# ABSTRACT: ReplicaSet ensures that a specified number of pod replicas are running at any given time.
our $VERSION = '1.002';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

ReplicaSet ensures that a specified number of pod replicas are running at any given time.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Apps::V1::ReplicaSetSpec';

=attr spec

Spec defines the specification of the desired behavior of the ReplicaSet. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut

k8s status => 'Apps::V1::ReplicaSetStatus';

=attr status

Status is the most recently observed status of the ReplicaSet. This data may be out of date by some window of time. Populated by the system. Read-only. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#replicaset-v1-apps>


=cut
1;
