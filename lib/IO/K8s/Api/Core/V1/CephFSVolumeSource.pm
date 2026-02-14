package IO::K8s::Api::Core::V1::CephFSVolumeSource;
# ABSTRACT: Represents a Ceph Filesystem mount that lasts the lifetime of a pod Cephfs volumes do not support ownership management or SELinux relabeling.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s monitors => [Str], 'required';

=attr monitors

monitors is Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it

=cut

k8s path => Str;

=attr path

path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it

=cut

k8s secretFile => Str;

=attr secretFile

secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it

=cut

k8s secretRef => 'Core::V1::LocalObjectReference';

=attr secretRef

secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it

=cut

k8s user => Str;

=attr user

user is optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it

=cut

1;
