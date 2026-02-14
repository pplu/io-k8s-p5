package IO::K8s::Api::Core::V1::AzureDiskVolumeSource;
# ABSTRACT: AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s cachingMode => Str;

=attr cachingMode

cachingMode is the Host Caching mode: None, Read Only, Read Write.

=cut

k8s diskName => Str, 'required';

=attr diskName

diskName is the Name of the data disk in the blob storage

=cut

k8s diskURI => Str, 'required';

=attr diskURI

diskURI is the URI of data disk in the blob storage

=cut

k8s fsType => Str;

=attr fsType

fsType is Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.

=cut

k8s kind => Str;

=attr kind

kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.

=cut

1;
