package IO::K8s::Api::Apps::V1::StatefulSetPersistentVolumeClaimRetentionPolicy;
# ABSTRACT: StatefulSetPersistentVolumeClaimRetentionPolicy describes the policy used for PVCs created from the StatefulSet VolumeClaimTemplates.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s whenDeleted => Str;

=attr whenDeleted

WhenDeleted specifies what happens to PVCs created from StatefulSet VolumeClaimTemplates when the StatefulSet is deleted. The default policy of `Retain` causes PVCs to not be affected by StatefulSet deletion. The `Delete` policy causes those PVCs to be deleted.

=cut

k8s whenScaled => Str;

=attr whenScaled

WhenScaled specifies what happens to PVCs created from StatefulSet VolumeClaimTemplates when the StatefulSet is scaled down. The default policy of `Retain` causes PVCs to not be affected by a scaledown. The `Delete` policy causes the associated PVCs for any excess pods above the replica count to be deleted.

=cut

1;
