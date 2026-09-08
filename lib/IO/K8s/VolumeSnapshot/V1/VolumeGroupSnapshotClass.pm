package IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshotClass;
# ABSTRACT: VolumeGroupSnapshotClass specifies parameters for a volume group snapshot
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'groupsnapshot.storage.k8s.io/v1',
    resource_plural => 'volumegroupsnapshotclasses';

=description

VolumeGroupSnapshotClass specifies parameters that a underlying storage system
uses when creating a volume group snapshot. A specific VolumeGroupSnapshotClass
is used by specifying its name in a VolumeGroupSnapshot object.
VolumeGroupSnapshotClasses are non-namespaced.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s deletionPolicy => Str, { required => 'schema', enum => [qw(Delete Retain)] };

=attr deletionPolicy

DeletionPolicy determines whether a VolumeGroupSnapshotContent created
through the VolumeGroupSnapshotClass should be deleted when its bound
VolumeGroupSnapshot is deleted.
Supported values are "Retain" and "Delete".
"Retain" means that the VolumeGroupSnapshotContent and its physical group
snapshot on underlying storage system are kept.
"Delete" means that the VolumeGroupSnapshotContent and its physical group
snapshot on underlying storage system are deleted.
Required.

=cut

k8s driver => Str, { required => 'schema' };

=attr driver

Driver is the name of the storage driver expected to handle this VolumeGroupSnapshotClass.
Required.

=cut

k8s parameters => { Str => 1 };

=attr parameters

Parameters is a key-value map with storage driver specific parameters for
creating group snapshots.
These values are opaque to Kubernetes and are passed directly to the driver.

=cut

=seealso

L<external-snapshotter v8.6.0 VolumeGroupSnapshotClass CRD|https://github.com/kubernetes-csi/external-snapshotter/blob/v8.6.0/client/config/crd/groupsnapshot.storage.k8s.io_volumegroupsnapshotclasses.yaml>

=cut

1;
