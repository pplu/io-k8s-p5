package IO::K8s::K3s::V1::ETCDSnapshotStatus;
# ABSTRACT: ETCDSnapshotStatus is the status of the ETCDSnapshotFile object.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s creationTime => Time;
k8s error        => '+IO::K8s::K3s::V1::ETCDSnapshotError';
k8s readyToUse   => Bool;
k8s size         => Quantity;

=attr creationTime

CreationTime is the timestamp when the snapshot was taken by etcd.

=cut

=attr error

Error is the last observed error during snapshot creation, if any.
If the snapshot is retried, this field will be cleared on success.

=cut

=attr readyToUse

ReadyToUse indicates that the snapshot is available to be restored.

=cut

=attr size

Size is the size of the snapshot file, in bytes. If not specified, the snapshot failed.

=cut

1;
