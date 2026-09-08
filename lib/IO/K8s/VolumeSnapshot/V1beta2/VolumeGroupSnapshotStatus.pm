package IO::K8s::VolumeSnapshot::V1beta2::VolumeGroupSnapshotStatus;
# ABSTRACT: VolumeGroupSnapshotStatus defines the observed state of a volume group snapshot
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s boundVolumeGroupSnapshotContentName => Str;

=attr boundVolumeGroupSnapshotContentName

BoundVolumeGroupSnapshotContentName is the name of the VolumeGroupSnapshotContent
object to which this VolumeGroupSnapshot object intends to bind to.
If not specified, it indicates that the VolumeGroupSnapshot object has not
been successfully bound to a VolumeGroupSnapshotContent object yet.
NOTE: To avoid possible security issues, consumers must verify binding between
VolumeGroupSnapshot and VolumeGroupSnapshotContent objects is successful
(by validating that both VolumeGroupSnapshot and VolumeGroupSnapshotContent
point at each other) before using this object.

=cut

k8s creationTime => Time;

=attr creationTime

CreationTime is the timestamp when the point-in-time group snapshot is taken
by the underlying storage system.
If not specified, it may indicate that the creation time of the group snapshot
is unknown.
This field is updated based on the CreationTime field in VolumeGroupSnapshotContentStatus

=cut

k8s error => '+IO::K8s::VolumeSnapshot::V1::VolumeSnapshotError';

=attr error

Error is the last observed error during group snapshot creation, if any.
This field could be helpful to upper level controllers (i.e., application
controller) to decide whether they should continue on waiting for the group
snapshot to be created based on the type of error reported.
The snapshot controller will keep retrying when an error occurs during the
group snapshot creation. Upon success, this error field will be cleared.

=cut

k8s readyToUse => Bool;

=attr readyToUse

ReadyToUse indicates if all the individual snapshots in the group are ready
to be used to restore a group of volumes.
ReadyToUse becomes true when ReadyToUse of all individual snapshots become true.
If not specified, it means the readiness of a group snapshot is unknown.

=cut

1;
