package IO::K8s::Api::Core::V1::ScaleIOVolumeSource;
# ABSTRACT: ScaleIOVolumeSource represents a persistent ScaleIO volume
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s fsType => Str;

=attr fsType

fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. "ext4", "xfs", "ntfs". Default is "xfs".

=cut

k8s gateway => Str, 'required';

=attr gateway

gateway is the host address of the ScaleIO API Gateway.

=cut

k8s protectionDomain => Str;

=attr protectionDomain

protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts.

=cut

k8s secretRef => 'Core::V1::LocalObjectReference', 'required';

=attr secretRef

secretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail.

=cut

k8s sslEnabled => Bool;

=attr sslEnabled

sslEnabled Flag enable/disable SSL communication with Gateway, default false

=cut

k8s storageMode => Str;

=attr storageMode

storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned.

=cut

k8s storagePool => Str;

=attr storagePool

storagePool is the ScaleIO Storage Pool associated with the protection domain.

=cut

k8s system => Str, 'required';

=attr system

system is the name of the storage system as configured in ScaleIO.

=cut

k8s volumeName => Str;

=attr volumeName

volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source.

=cut

1;
