package IO::K8s::K3s::V1::ETCDSnapshotFile;
# ABSTRACT: ETCDSnapshot tracks a point-in-time snapshot of the etcd datastore.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'k3s.cattle.io/v1',
    resource_plural => 'etcdsnapshotfiles';

k8s spec   => '+IO::K8s::K3s::V1::ETCDSnapshotSpec', { required => 'schema' };
k8s status => '+IO::K8s::K3s::V1::ETCDSnapshotStatus';

=attr spec

Spec defines properties of an etcd snapshot file

=cut

=attr status

Status represents current information about a snapshot.

=cut

1;
