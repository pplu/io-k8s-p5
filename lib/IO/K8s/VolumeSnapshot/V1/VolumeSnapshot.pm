package IO::K8s::VolumeSnapshot::V1::VolumeSnapshot;
# ABSTRACT: VolumeSnapshot is a user's request for either creating a point-in-time snapshot of a persistent volume, or binding to a pre-existing snapshot
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'snapshot.storage.k8s.io/v1',
    resource_plural => 'volumesnapshots';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotSpec', { required => 'schema' };
k8s status => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotStatus';

=attr spec

spec defines the desired characteristics of a snapshot requested by a user. More info: https://kubernetes.io/docs/concepts/storage/volume-snapshots#volumesnapshots Required.

=cut

=attr status

status represents the current information of a snapshot. Consumers must verify binding between VolumeSnapshot and VolumeSnapshotContent objects is successful (by validating that both VolumeSnapshot and VolumeSnapshotContent point at each other) before using this object.

=cut

1;
