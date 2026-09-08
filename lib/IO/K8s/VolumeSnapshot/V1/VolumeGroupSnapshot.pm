package IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshot;
# ABSTRACT: VolumeGroupSnapshot is a user's request for creating a point-in-time group snapshot
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'groupsnapshot.storage.k8s.io/v1',
    resource_plural => 'volumegroupsnapshots';
with 'IO::K8s::Role::Namespaced';

=description

VolumeGroupSnapshot is a user's request for creating either a point-in-time
group snapshot or binding to a pre-existing group snapshot.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec   => '+IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshotSpec', { required => 'schema' };

=attr spec

Spec defines the desired characteristics of a group snapshot requested by a user.
Required.

=cut

k8s status => '+IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshotStatus';

=attr status

Status represents the current information of a group snapshot.
Consumers must verify binding between VolumeGroupSnapshot and
VolumeGroupSnapshotContent objects is successful (by validating that both
VolumeGroupSnapshot and VolumeGroupSnapshotContent point to each other) before
using this object.

=cut

=seealso

L<external-snapshotter v8.6.0 VolumeGroupSnapshot CRD|https://github.com/kubernetes-csi/external-snapshotter/blob/v8.6.0/client/config/crd/groupsnapshot.storage.k8s.io_volumegroupsnapshots.yaml>

=cut

1;
