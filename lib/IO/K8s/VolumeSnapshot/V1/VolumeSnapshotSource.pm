package IO::K8s::VolumeSnapshot::V1::VolumeSnapshotSource;
# ABSTRACT: VolumeSnapshotSource specifies whether the underlying snapshot should be dynamically taken upon creation or if a pre-existing VolumeSnapshotContent object should be used
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s persistentVolumeClaimName => Str;
k8s volumeSnapshotContentName => Str;

=attr persistentVolumeClaimName

persistentVolumeClaimName specifies the name of the PersistentVolumeClaim object representing the volume from which a snapshot should be created. This PVC is assumed to be in the same namespace as the VolumeSnapshot object. This field should be set if the snapshot does not exists, and needs to be created. This field is immutable.

=cut

=attr volumeSnapshotContentName

volumeSnapshotContentName specifies the name of a pre-existing VolumeSnapshotContent object representing an existing volume snapshot. This field should be set if the snapshot already exists and only needs a representation in Kubernetes. This field is immutable.

=cut

1;
