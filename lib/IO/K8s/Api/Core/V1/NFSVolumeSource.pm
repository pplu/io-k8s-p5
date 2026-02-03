package IO::K8s::Api::Core::V1::NFSVolumeSource;
# ABSTRACT: Represents an NFS mount that lasts the lifetime of a pod. NFS volumes do not support ownership management or SELinux relabeling.

use IO::K8s::Resource;

k8s path => Str, 'required';

=attr path

path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs

=cut

k8s server => Str, 'required';

=attr server

server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs

=cut

1;
