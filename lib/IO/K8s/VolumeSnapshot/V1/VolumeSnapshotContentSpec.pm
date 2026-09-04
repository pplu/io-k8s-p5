package IO::K8s::VolumeSnapshot::V1::VolumeSnapshotContentSpec;
# ABSTRACT: VolumeSnapshotContentSpec is the specification of a VolumeSnapshotContent
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s deletionPolicy          => Str, { enum => [qw(Delete Retain)], required => 'schema' };
k8s driver                  => Str, { required => 'schema' };
k8s source                  => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotContentSource', { required => 'schema' };
k8s sourceVolumeMode        => Str;
k8s volumeSnapshotClassName => Str;
k8s volumeSnapshotRef       => 'Core::V1::ObjectReference', { required => 'schema' };

=attr deletionPolicy

deletionPolicy determines whether this VolumeSnapshotContent and its physical snapshot on the underlying storage system should be deleted when its bound VolumeSnapshot is deleted. Supported values are "Retain" and "Delete". "Retain" means that the VolumeSnapshotContent and its physical snapshot on underlying storage system are kept. "Delete" means that the VolumeSnapshotContent and its physical snapshot on underlying storage system are deleted. For dynamically provisioned snapshots, this field will automatically be filled in by the CSI snapshotter sidecar with the "DeletionPolicy" field defined in the corresponding VolumeSnapshotClass. For pre-existing snapshots, users MUST specify this field when creating the VolumeSnapshotContent object. Required.

=cut

=attr driver

driver is the name of the CSI driver used to create the physical snapshot on the underlying storage system. This MUST be the same as the name returned by the CSI GetPluginName() call for that driver. Required.

=cut

=attr source

source specifies whether the snapshot is (or should be) dynamically provisioned or already exists, and just requires a Kubernetes object representation. This field is immutable after creation. Required.

=cut

=attr sourceVolumeMode

SourceVolumeMode is the mode of the volume whose snapshot is taken. Can be either "Filesystem" or "Block". If not specified, it indicates the source volume's mode is unknown. This field is immutable. This field is an alpha field.

=cut

=attr volumeSnapshotClassName

name of the VolumeSnapshotClass from which this snapshot was (or will be) created. Note that after provisioning, the VolumeSnapshotClass may be deleted or recreated with different set of values, and as such, should not be referenced post-snapshot creation.

=cut

=attr volumeSnapshotRef

volumeSnapshotRef specifies the VolumeSnapshot object to which this VolumeSnapshotContent object is bound. VolumeSnapshot.Spec.VolumeSnapshotContentName field must reference to this VolumeSnapshotContent's name for the bidirectional binding to be valid. For a pre-existing VolumeSnapshotContent object, name and namespace of the VolumeSnapshot object MUST be provided for binding to happen. This field is immutable after creation. Required.

=cut

1;
