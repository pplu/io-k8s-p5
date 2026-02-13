package IO::K8s::Api::Core::V1::PortworxVolumeSource;
# ABSTRACT: PortworxVolumeSource represents a Portworx volume resource.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s fsType => Str;

=attr fsType

fSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs". Implicitly inferred to be "ext4" if unspecified.

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.

=cut

k8s volumeID => Str, 'required';

=attr volumeID

volumeID uniquely identifies a Portworx volume

=cut

1;
