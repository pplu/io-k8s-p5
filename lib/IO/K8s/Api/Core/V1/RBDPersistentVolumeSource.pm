package IO::K8s::Api::Core::V1::RBDPersistentVolumeSource;
# ABSTRACT: Represents a Rados Block Device mount that lasts the lifetime of a pod. RBD volumes support ownership management and SELinux relabeling.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s fsType => Str;

=attr fsType

fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd

=cut

k8s image => Str, 'required';

=attr image

image is the rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it

=cut

k8s keyring => Str;

=attr keyring

keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it

=cut

k8s monitors => [Str], 'required';

=attr monitors

monitors is a collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it

=cut

k8s pool => Str;

=attr pool

pool is the rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it

=cut

k8s secretRef => 'Core::V1::SecretReference';

=attr secretRef

secretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it

=cut

k8s user => Str;

=attr user

user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it

=cut

1;
