package IO::K8s::Api::Core::V1::CSIPersistentVolumeSource;
# ABSTRACT: Represents storage that is managed by an external CSI volume driver (Beta feature)
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s controllerExpandSecretRef => 'Core::V1::SecretReference';

=attr controllerExpandSecretRef

controllerExpandSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerExpandVolume call. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.

=cut

k8s controllerPublishSecretRef => 'Core::V1::SecretReference';

=attr controllerPublishSecretRef

controllerPublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI ControllerPublishVolume and ControllerUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.

=cut

k8s driver => Str, 'required';

=attr driver

driver is the name of the driver to use for this volume. Required.

=cut

k8s fsType => Str;

=attr fsType

fsType to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs".

=cut

k8s nodeExpandSecretRef => 'Core::V1::SecretReference';

=attr nodeExpandSecretRef

nodeExpandSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodeExpandVolume call. This field is optional, may be omitted if no secret is required. If the secret object contains more than one secret, all secrets are passed.

=cut

k8s nodePublishSecretRef => 'Core::V1::SecretReference';

=attr nodePublishSecretRef

nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.

=cut

k8s nodeStageSecretRef => 'Core::V1::SecretReference';

=attr nodeStageSecretRef

nodeStageSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodeStageVolume and NodeStageVolume and NodeUnstageVolume calls. This field is optional, and may be empty if no secret is required. If the secret object contains more than one secret, all secrets are passed.

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly value to pass to ControllerPublishVolumeRequest. Defaults to false (read/write).

=cut

k8s volumeAttributes => { Str => 1 };

=attr volumeAttributes

volumeAttributes of the volume to publish.

=cut

k8s volumeHandle => Str, 'required';

=attr volumeHandle

volumeHandle is the unique volume name returned by the CSI volume plugin’s CreateVolume to refer to the volume on all subsequent calls. Required.

=cut

1;
