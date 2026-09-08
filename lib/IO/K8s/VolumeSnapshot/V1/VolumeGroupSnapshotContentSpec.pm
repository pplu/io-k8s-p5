package IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshotContentSpec;
# ABSTRACT: VolumeGroupSnapshotContentSpec describes common group snapshot content attributes
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s deletionPolicy => Str, { required => 'schema', enum => [qw(Delete Retain)] };

=attr deletionPolicy

DeletionPolicy determines whether this VolumeGroupSnapshotContent and the
physical group snapshot on the underlying storage system should be deleted
when the bound VolumeGroupSnapshot is deleted.
Supported values are "Retain" and "Delete".
"Retain" means that the VolumeGroupSnapshotContent and its physical group
snapshot on underlying storage system are kept.
"Delete" means that the VolumeGroupSnapshotContent and its physical group
snapshot on underlying storage system are deleted.
For dynamically provisioned group snapshots, this field will automatically
be filled in by the CSI snapshotter sidecar with the "DeletionPolicy" field
defined in the corresponding VolumeGroupSnapshotClass.
For pre-existing snapshots, users MUST specify this field when creating the
VolumeGroupSnapshotContent object.
Required.

=cut

k8s driver => Str, { required => 'schema' };

=attr driver

Driver is the name of the CSI driver used to create the physical group snapshot on
the underlying storage system.
This MUST be the same as the name returned by the CSI GetPluginName() call for
that driver.
Required.

=cut

k8s source => '+IO::K8s::VolumeSnapshot::V1::VolumeGroupSnapshotContentSource', { required => 'schema' };

=attr source

Source specifies whether the snapshot is (or should be) dynamically provisioned
or already exists, and just requires a Kubernetes object representation.
This field is immutable after creation.
Required.

=cut

k8s volumeGroupSnapshotClassName => Str;

=attr volumeGroupSnapshotClassName

VolumeGroupSnapshotClassName is the name of the VolumeGroupSnapshotClass from
which this group snapshot was (or will be) created.
Note that after provisioning, the VolumeGroupSnapshotClass may be deleted or
recreated with different set of values, and as such, should not be referenced
post-snapshot creation.
For dynamic provisioning, this field must be set.
This field may be unset for pre-provisioned snapshots.

=cut

k8s volumeGroupSnapshotRef => 'Core::V1::ObjectReference', { required => 'schema' };

=attr volumeGroupSnapshotRef

VolumeGroupSnapshotRef specifies the VolumeGroupSnapshot object to which this
VolumeGroupSnapshotContent object is bound.
VolumeGroupSnapshot.Spec.VolumeGroupSnapshotContentName field must reference to
this VolumeGroupSnapshotContent's name for the bidirectional binding to be valid.
For a pre-existing VolumeGroupSnapshotContent object, name and namespace of the
VolumeGroupSnapshot object MUST be provided for binding to happen.
This field is immutable after creation.
Required.

=cut

1;
