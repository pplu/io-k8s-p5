package IO::K8s::Api::Core::V1::VolumeDevice;
# ABSTRACT: volumeDevice describes a mapping of a raw block device within a container.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s devicePath => Str, 'required';

=attr devicePath

devicePath is the path inside of the container that the device will be mapped to.

=cut

k8s name => Str, 'required';

=attr name

name must match the name of a persistentVolumeClaim in the pod

=cut

1;
