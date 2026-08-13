package IO::K8s::Api::Core::V1::ImageVolumeStatus;
# ABSTRACT: ImageVolumeStatus represents the image-based volume status.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s imageRef => Str, 'required';

=attr imageRef

ImageRef is the digest of the image used for this volume. It should have a value that's similar to the pod's status.containerStatuses[i].imageID. The ImageRef length should not exceed 256 characters.

=cut

1;
