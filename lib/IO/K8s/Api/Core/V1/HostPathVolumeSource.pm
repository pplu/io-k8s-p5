package IO::K8s::Api::Core::V1::HostPathVolumeSource;
# ABSTRACT: Represents a host path mapped into a pod. Host path volumes do not support ownership management or SELinux relabeling.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s path => Str, 'required';

=attr path

path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath

=cut

k8s type => Str;

=attr type

type for HostPath Volume Defaults to "" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath

=cut

1;
