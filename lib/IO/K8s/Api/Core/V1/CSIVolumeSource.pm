package IO::K8s::Api::Core::V1::CSIVolumeSource;
# ABSTRACT: Represents a source location of a volume to mount, managed by an external CSI driver
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s driver => Str, 'required';

=attr driver

driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster.

=cut

k8s fsType => Str;

=attr fsType

fsType to mount. Ex. "ext4", "xfs", "ntfs". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply.

=cut

k8s nodePublishSecretRef => 'Core::V1::LocalObjectReference';

=attr nodePublishSecretRef

nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed.

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly specifies a read-only configuration for the volume. Defaults to false (read/write).

=cut

k8s volumeAttributes => { Str => 1 };

=attr volumeAttributes

volumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values.

=cut

1;
