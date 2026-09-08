package IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshotContentSource;
# ABSTRACT: VolumeGroupSnapshotContentSource represents the CSI source of a group snapshot
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s groupSnapshotHandles => '+IO::K8s::VolumeSnapshot::V1::GroupSnapshotHandles';

=attr groupSnapshotHandles

GroupSnapshotHandles specifies the CSI "group_snapshot_id" of a pre-existing
group snapshot and a list of CSI "snapshot_id" of pre-existing snapshots
on the underlying storage system for which a Kubernetes object
representation was (or should be) created.
This field is immutable.

=cut

k8s volumeHandles => [Str];

=attr volumeHandles

VolumeHandles is a list of volume handles on the backend to be snapshotted
together. It is specified for dynamic provisioning of the VolumeGroupSnapshot.
This field is immutable.

=cut

1;
