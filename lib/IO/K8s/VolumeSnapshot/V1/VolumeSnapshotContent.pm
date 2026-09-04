package IO::K8s::VolumeSnapshot::V1::VolumeSnapshotContent;
# ABSTRACT: VolumeSnapshotContent represents the actual "on-disk" snapshot object in the underlying storage system
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'snapshot.storage.k8s.io/v1',
    resource_plural => 'volumesnapshotcontents';

k8s spec   => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotContentSpec', { required => 'schema' };
k8s status => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotContentStatus';

=attr spec

spec defines properties of a VolumeSnapshotContent created by the underlying storage system. Required.

=cut

=attr status

status represents the current information of a snapshot.

=cut

1;
