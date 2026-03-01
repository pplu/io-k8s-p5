package IO::K8s::Api::Core::V1::LocalVolumeSource;
# ABSTRACT: Local represents directly-attached storage with node affinity (Beta feature)
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s fsType => Str;

=attr fsType

fsType is the filesystem type to mount. It applies only when the Path is a block device. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default value is to auto-select a filesystem if unspecified.

=cut

k8s path => Str, 'required';

=attr path

path of the full path to the volume on the node. It can be either a directory or block device (disk, partition, ...).

=cut

1;
