package IO::K8s::Api::Core::V1::FlexVolumeSource;
# ABSTRACT: FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s driver => Str, 'required';

=attr driver

driver is the name of the driver to use for this volume.

=cut

k8s fsType => Str;

=attr fsType

fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". The default filesystem depends on FlexVolume script.

=cut

k8s options => { Str => 1 };

=attr options

options is Optional: this field holds extra command options if any.

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.

=cut

k8s secretRef => 'Core::V1::LocalObjectReference';

=attr secretRef

secretRef is Optional: secretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts.

=cut

1;
