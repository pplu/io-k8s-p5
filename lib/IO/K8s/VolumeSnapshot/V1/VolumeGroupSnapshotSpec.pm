package IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshotSpec;
# ABSTRACT: VolumeGroupSnapshotSpec defines the desired state of a volume group snapshot
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s source => '+IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshotSource', { required => 'schema' };

=attr source

Source specifies where a group snapshot will be created from.
This field is immutable after creation.
Required.

=cut

k8s volumeGroupSnapshotClassName => Str;

=attr volumeGroupSnapshotClassName

VolumeGroupSnapshotClassName is the name of the VolumeGroupSnapshotClass
requested by the VolumeGroupSnapshot.
VolumeGroupSnapshotClassName may be left nil to indicate that the default
class will be used.
Empty string is not allowed for this field.

=cut

1;
