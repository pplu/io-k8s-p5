package IO::K8s::VolumeSnapshot::V1::GroupSnapshotHandles;
# ABSTRACT: GroupSnapshotHandles identifies a pre-existing CSI group snapshot
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s volumeGroupSnapshotHandle => Str, { required => 'schema' };

=attr volumeGroupSnapshotHandle

VolumeGroupSnapshotHandle specifies the CSI "group_snapshot_id" of a pre-existing
group snapshot on the underlying storage system for which a Kubernetes object
representation was (or should be) created.
This field is immutable.
Required.

=cut

k8s volumeSnapshotHandles => [Str], { required => 'schema' };

=attr volumeSnapshotHandles

VolumeSnapshotHandles is a list of CSI "snapshot_id" of pre-existing
snapshots on the underlying storage system for which Kubernetes objects
representation were (or should be) created.
This field is immutable.
Required.

=cut

1;
