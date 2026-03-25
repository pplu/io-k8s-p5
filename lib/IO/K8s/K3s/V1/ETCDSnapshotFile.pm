package IO::K8s::K3s::V1::ETCDSnapshotFile;
# ABSTRACT: K3s etcd snapshot file
our $VERSION = '1.101';
use IO::K8s::APIObject
    api_version     => 'k3s.cattle.io/v1',
    resource_plural => 'etcdsnapshotfiles';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This class represents an ETCDSnapshotFile custom resource in the C<k3s.cattle.io/v1> API group. ETCDSnapshotFile resources track point-in-time snapshots of the etcd datastore, recording the snapshot name, node, location (local file:// or S3 s3:// URI), and status information such as size and creation time. This is a cluster-scoped resource (not namespaced) where the C<spec> and C<status> fields are opaque hash structures defined by the K3s API.

=seealso

=over

=item * L<IO::K8s::K3s> - K3s custom resources

=item * L<https://docs.k3s.io/datastore/etcd-backup-restore> - K3s etcd Backup and Restore Documentation

=back

=cut
