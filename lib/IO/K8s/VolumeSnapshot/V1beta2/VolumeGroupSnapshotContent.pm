package IO::K8s::VolumeSnapshot::V1beta2::VolumeGroupSnapshotContent;
# ABSTRACT: VolumeGroupSnapshotContent represents an on-disk group snapshot
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'groupsnapshot.storage.k8s.io/v1beta2',
    resource_plural => 'volumegroupsnapshotcontents';

=description

VolumeGroupSnapshotContent represents the actual "on-disk" group snapshot object
in the underlying storage system.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => '+IO::K8s::VolumeSnapshot::V1beta2::VolumeGroupSnapshotContentSpec', { required => 'schema' };

=attr spec

Spec defines properties of a VolumeGroupSnapshotContent created by the underlying storage system.
Required.

=cut

k8s status => '+IO::K8s::VolumeSnapshot::V1beta2::VolumeGroupSnapshotContentStatus';

=attr status

status represents the current information of a group snapshot.

=cut

=seealso

L<external-snapshotter v8.6.0 VolumeGroupSnapshotContent CRD|https://github.com/kubernetes-csi/external-snapshotter/blob/v8.6.0/client/config/crd/groupsnapshot.storage.k8s.io_volumegroupsnapshotcontents.yaml>

=cut

1;
