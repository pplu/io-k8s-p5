package IO::K8s::Api::Core::V1::VsphereVirtualDiskVolumeSource;
# ABSTRACT: Represents a vSphere volume resource.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s fsType => Str;

=attr fsType

fsType is filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.

=cut

k8s storagePolicyID => Str;

=attr storagePolicyID

storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.

=cut

k8s storagePolicyName => Str;

=attr storagePolicyName

storagePolicyName is the storage Policy Based Management (SPBM) profile name.

=cut

k8s volumePath => Str, 'required';

=attr volumePath

volumePath is the path that identifies vSphere volume vmdk

=cut

1;
