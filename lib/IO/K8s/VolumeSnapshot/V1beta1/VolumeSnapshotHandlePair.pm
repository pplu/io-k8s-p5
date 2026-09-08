package IO::K8s::VolumeSnapshot::V1beta1::VolumeSnapshotHandlePair;
# ABSTRACT: VolumeSnapshotHandlePair defines a source volume and snapshot handle pair
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s snapshotHandle => Str, { required => 'schema' };

=attr snapshotHandle

SnapshotHandle is a unique id returned by the CSI driver to identify a volume
snapshot on the storage system.
Required.

=cut

k8s volumeHandle => Str, { required => 'schema' };

=attr volumeHandle

VolumeHandle is a unique id returned by the CSI driver to identify a volume
on the storage system.
Required.

=cut

1;
