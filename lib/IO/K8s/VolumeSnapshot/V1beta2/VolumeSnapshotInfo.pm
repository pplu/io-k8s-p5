package IO::K8s::VolumeSnapshot::V1beta2::VolumeSnapshotInfo;
# ABSTRACT: VolumeSnapshotInfo contains information for a snapshot
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s creationTime => Int;

=attr creationTime

creationTime is the timestamp when the point-in-time snapshot is taken
by the underlying storage system.

=cut

k8s readyToUse => Bool;

=attr readyToUse

ReadyToUse indicates if the snapshot is ready to be used to restore a volume.

=cut

k8s restoreSize => Int;

=attr restoreSize

RestoreSize represents the minimum size of volume required to create a volume
from this snapshot.

=cut

k8s snapshotHandle => Str;

=attr snapshotHandle

SnapshotHandle is the CSI "snapshot_id" of this snapshot on the underlying storage system.

=cut

k8s volumeHandle => Str;

=attr volumeHandle

VolumeHandle specifies the CSI "volume_id" of the volume from which this snapshot
was taken from.

=cut

1;
