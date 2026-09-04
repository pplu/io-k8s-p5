package IO::K8s::VolumeSnapshot::V1::VolumeSnapshotContentStatus;
# ABSTRACT: VolumeSnapshotContentStatus is the status of a VolumeSnapshotContent object
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s creationTime              => Int;
k8s error                     => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotError';
k8s readyToUse                => Bool;
k8s restoreSize               => Int, { minimum => 0 };
k8s snapshotHandle            => Str;
k8s volumeGroupSnapshotHandle => Str;

=attr creationTime

creationTime is the timestamp when the point-in-time snapshot is taken by the underlying storage system. In dynamic snapshot creation case, this field will be filled in by the CSI snapshotter sidecar with the "creation_time" value returned from CSI "CreateSnapshot" gRPC call. For a pre-existing snapshot, this field will be filled with the "creation_time" value returned from the CSI "ListSnapshots" gRPC call if the driver supports it. If not specified, it indicates the creation time is unknown. The format of this field is a Unix nanoseconds time encoded as an int64. On Unix, the command `date +%s%N` returns the current time in nanoseconds since 1970-01-01 00:00:00 UTC.

=cut

=attr error

error is the last observed error during snapshot creation, if any. Upon success after retry, this error field will be cleared.

=cut

=attr readyToUse

readyToUse indicates if a snapshot is ready to be used to restore a volume. In dynamic snapshot creation case, this field will be filled in by the CSI snapshotter sidecar with the "ready_to_use" value returned from CSI "CreateSnapshot" gRPC call. For a pre-existing snapshot, this field will be filled with the "ready_to_use" value returned from the CSI "ListSnapshots" gRPC call if the driver supports it, otherwise, this field will be set to "True". If not specified, it means the readiness of a snapshot is unknown.

=cut

=attr restoreSize

restoreSize represents the complete size of the snapshot in bytes. In dynamic snapshot creation case, this field will be filled in by the CSI snapshotter sidecar with the "size_bytes" value returned from CSI "CreateSnapshot" gRPC call. For a pre-existing snapshot, this field will be filled with the "size_bytes" value returned from the CSI "ListSnapshots" gRPC call if the driver supports it. When restoring a volume from this snapshot, the size of the volume MUST NOT be smaller than the restoreSize if it is specified, otherwise the restoration will fail. If not specified, it indicates that the size is unknown.

=cut

=attr snapshotHandle

snapshotHandle is the CSI "snapshot_id" of a snapshot on the underlying storage system. If not specified, it indicates that dynamic snapshot creation has either failed or it is still in progress.

=cut

=attr volumeGroupSnapshotHandle

VolumeGroupSnapshotHandle is the CSI "group_snapshot_id" of a group snapshot on the underlying storage system.

=cut

1;
