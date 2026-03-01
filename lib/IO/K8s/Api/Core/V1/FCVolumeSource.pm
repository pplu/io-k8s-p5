package IO::K8s::Api::Core::V1::FCVolumeSource;
# ABSTRACT: Represents a Fibre Channel volume. Fibre Channel volumes can only be mounted as read/write once. Fibre Channel volumes support ownership management and SELinux relabeling.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s fsType => Str;

=attr fsType

fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified.

=cut

k8s lun => Int;

=attr lun

lun is Optional: FC target lun number

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.

=cut

k8s targetWWNs => [Str];

=attr targetWWNs

targetWWNs is Optional: FC target worldwide names (WWNs)

=cut

k8s wwids => [Str];

=attr wwids

wwids Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously.

=cut

1;
