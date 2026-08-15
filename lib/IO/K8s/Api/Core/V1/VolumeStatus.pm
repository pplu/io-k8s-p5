package IO::K8s::Api::Core::V1::VolumeStatus;
# ABSTRACT: VolumeStatus represents the status of a mounted volume. At most one of its members must be specified.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s image => 'Core::V1::ImageVolumeStatus';

=attr image

image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine.

=cut

1;
