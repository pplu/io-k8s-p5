package IO::K8s::VolumeSnapshot::V1::VolumeSnapshotClass;
# ABSTRACT: VolumeSnapshotClass specifies parameters that a underlying storage system uses when creating a volume snapshot
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'snapshot.storage.k8s.io/v1',
    resource_plural => 'volumesnapshotclasses';

k8s deletionPolicy => Str, { enum => [qw(Delete Retain)], required => 'schema' };
k8s driver         => Str, { required => 'schema' };
k8s parameters     => { Str => 1 };

=attr deletionPolicy

deletionPolicy determines whether a VolumeSnapshotContent created through the VolumeSnapshotClass should be deleted when its bound VolumeSnapshot is deleted. Supported values are "Retain" and "Delete". "Retain" means that the VolumeSnapshotContent and its physical snapshot on underlying storage system are kept. "Delete" means that the VolumeSnapshotContent and its physical snapshot on underlying storage system are deleted. Required.

=cut

=attr driver

driver is the name of the storage driver that handles this VolumeSnapshotClass. Required.

=cut

=attr parameters

parameters is a key-value map with storage driver specific parameters for creating snapshots. These values are opaque to Kubernetes.

=cut

1;
