package IO::K8s::VolumeSnapshot::V1beta2::VolumeGroupSnapshotSource;
# ABSTRACT: VolumeGroupSnapshotSource specifies a new or pre-existing group snapshot source
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s selector => 'Meta::V1::LabelSelector';

=attr selector

Selector is a label query over persistent volume claims that are to be
grouped together for snapshotting.
This labelSelector will be used to match the label added to a PVC.
If the label is added or removed to a volume after a group snapshot
is created, the existing group snapshots won't be modified.
Once a VolumeGroupSnapshotContent is created and the sidecar starts to process
it, the volume list will not change with retries.

=cut

k8s volumeGroupSnapshotContentName => Str;

=attr volumeGroupSnapshotContentName

VolumeGroupSnapshotContentName specifies the name of a pre-existing VolumeGroupSnapshotContent
object representing an existing volume group snapshot.
This field should be set if the volume group snapshot already exists and
only needs a representation in Kubernetes.
This field is immutable.

=cut

1;
