package IO::K8s::Api::Core::V1::PersistentVolumeClaim;
# ABSTRACT: PersistentVolumeClaim is a user's request for and claim to a persistent volume
our $VERSION = '1.002';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

PersistentVolumeClaim is a user's request for and claim to a persistent volume

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Core::V1::PersistentVolumeClaimSpec';

=attr spec

spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims


=cut

k8s status => 'Core::V1::PersistentVolumeClaimStatus';

=attr status

status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#persistentvolumeclaim-v1-core>


=cut
1;
