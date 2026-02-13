package IO::K8s::Api::Core::V1::StorageOSVolumeSource;
# ABSTRACT: Represents a StorageOS persistent volume resource.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s fsType => Str;

=attr fsType

fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.

=cut

k8s secretRef => 'Core::V1::LocalObjectReference';

=attr secretRef

secretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted.

=cut

k8s volumeName => Str;

=attr volumeName

volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace.

=cut

k8s volumeNamespace => Str;

=attr volumeNamespace

volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to "default" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created.

=cut

1;
