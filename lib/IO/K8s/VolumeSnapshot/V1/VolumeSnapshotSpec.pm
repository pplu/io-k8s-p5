package IO::K8s::VolumeSnapshot::V1::VolumeSnapshotSpec;
# ABSTRACT: VolumeSnapshotSpec describes the common attributes of a volume snapshot
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s source                  => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotSource', { required => 'schema' };
k8s volumeSnapshotClassName => Str;

=attr source

source specifies where a snapshot will be created from. This field is immutable after creation. Required.

=cut

=attr volumeSnapshotClassName

VolumeSnapshotClassName is the name of the VolumeSnapshotClass requested by the VolumeSnapshot. VolumeSnapshotClassName may be left nil to indicate that the default SnapshotClass should be used. A given cluster may have multiple default Volume SnapshotClasses: one default per CSI Driver. If a VolumeSnapshot does not specify a SnapshotClass, VolumeSnapshotSource will be checked to figure out what the associated CSI Driver is, and the default VolumeSnapshotClass associated with that CSI Driver will be used. If more than one VolumeSnapshotClass exist for a given CSI Driver and more than one have been marked as default, CreateSnapshot will fail and generate an event. Empty string is not allowed for this field.

=cut

1;
