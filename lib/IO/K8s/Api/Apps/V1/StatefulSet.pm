package IO::K8s::Api::Apps::V1::StatefulSet;
# ABSTRACT: StatefulSet represents a set of pods with consistent identities.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

StatefulSet represents a set of pods with consistent identities. Identities are defined as: Network: A single stable DNS and hostname. Storage: As many VolumeClaims as requested. The StatefulSet guarantees that a given network identity will always map to the same storage identity.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Apps::V1::StatefulSetSpec';

=attr spec

Spec defines the desired identities of pods in this set.


=cut

k8s status => 'Apps::V1::StatefulSetStatus';

=attr status

Status is the current status of Pods in this StatefulSet. This data may be out of date by some window of time.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#statefulset-v1-apps>


=cut
1;
