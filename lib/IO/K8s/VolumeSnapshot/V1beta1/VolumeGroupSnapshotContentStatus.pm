package IO::K8s::VolumeSnapshot::V1beta1::VolumeGroupSnapshotContentStatus;
# ABSTRACT: VolumeGroupSnapshotContentStatus defines the observed group snapshot content state
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s creationTime => Time;

=attr creationTime

CreationTime is the timestamp when the point-in-time group snapshot is taken
by the underlying storage system.
If not specified, it indicates the creation time is unknown.
If not specified, it means the readiness of a group snapshot is unknown.
This field is the source for the CreationTime field in VolumeGroupSnapshotStatus

=cut

k8s error => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotError';

=attr error

Error is the last observed error during group snapshot creation, if any.
Upon success after retry, this error field will be cleared.

=cut

k8s readyToUse => Bool;

=attr readyToUse

ReadyToUse indicates if all the individual snapshots in the group are ready to be
used to restore a group of volumes.
ReadyToUse becomes true when ReadyToUse of all individual snapshots become true.

=cut

k8s volumeGroupSnapshotHandle => Str;

=attr volumeGroupSnapshotHandle

VolumeGroupSnapshotHandle is a unique id returned by the CSI driver
to identify the VolumeGroupSnapshot on the storage system.
If a storage system does not provide such an id, the
CSI driver can choose to return the VolumeGroupSnapshot name.

=cut

k8s volumeSnapshotHandlePairList => ['+IO::K8s::VolumeSnapshot::V1beta1::VolumeSnapshotHandlePair'];

=attr volumeSnapshotHandlePairList

VolumeSnapshotHandlePairList is a list of CSI "volume_id" and "snapshot_id"
pair returned by the CSI driver to identify snapshots and their source volumes
on the storage system.

=cut

1;
