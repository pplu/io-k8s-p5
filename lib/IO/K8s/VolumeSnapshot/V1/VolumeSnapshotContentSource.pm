package IO::K8s::VolumeSnapshot::V1::VolumeSnapshotContentSource;
# ABSTRACT: source specifies whether the snapshot is (or should be) dynamically provisioned or already exists, and just requires a Kubernetes object representation.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s snapshotHandle => Str;
k8s volumeHandle   => Str;

=attr snapshotHandle

snapshotHandle specifies the CSI "snapshot_id" of a pre-existing snapshot on
the underlying storage system for which a Kubernetes object representation
was (or should be) created.
This field is immutable.

=cut

=attr volumeHandle

volumeHandle specifies the CSI "volume_id" of the volume from which a snapshot
should be dynamically taken from.
This field is immutable.

=cut

1;
