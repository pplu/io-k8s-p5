package IO::K8s::Api::Core::V1::GlusterfsVolumeSource;
# ABSTRACT: Represents a Glusterfs mount that lasts the lifetime of a pod. Glusterfs volumes do not support ownership management or SELinux relabeling.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s endpoints => Str, 'required';

=attr endpoints

endpoints is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod

=cut

k8s path => Str, 'required';

=attr path

path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod

=cut

k8s readOnly => Bool;

=attr readOnly

readOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod

=cut

1;
