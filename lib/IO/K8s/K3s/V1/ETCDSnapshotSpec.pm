package IO::K8s::K3s::V1::ETCDSnapshotSpec;
# ABSTRACT: ETCDSnapshotSpec desribes an etcd snapshot file
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s location     => Str, { required => 'schema' };
k8s metadata     => { Str => 1 };
k8s nodeName     => Str, { required => 'schema' };
k8s s3           => '+IO::K8s::K3s::V1::ETCDSnapshotS3';
k8s snapshotName => Str, { required => 'schema' };

=attr location

Location is the absolute file:// or s3:// URI address of the snapshot.

=cut

=attr metadata

Metadata contains point-in-time snapshot of the contents of the
k3s-etcd-snapshot-extra-metadata ConfigMap's data field, at the time the
snapshot was taken. This is intended to contain data about cluster state
that may be important for an external system to have available when restoring
the snapshot.

=cut

=attr nodeName

NodeName contains the name of the node that took the snapshot.

=cut

=attr s3

S3 contains extra metadata about the S3 storage system holding the
snapshot. This is guaranteed to be set for all snapshots uploaded to S3.
If not specified, the snapshot was not uploaded to S3.

=cut

=attr snapshotName

SnapshotName contains the base name of the snapshot file. CLI actions that act
on snapshots stored locally or within a pre-configured S3 bucket and
prefix usually take the snapshot name as their argument.

=cut

1;
