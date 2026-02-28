package IO::K8s::Api::Core::V1::PhotonPersistentDiskVolumeSource;
# ABSTRACT: Represents a Photon Controller persistent disk resource.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s fsType => Str;

=attr fsType

fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.

=cut

k8s pdID => Str, 'required';

=attr pdID

pdID is the ID that identifies Photon Controller persistent disk

=cut

1;
