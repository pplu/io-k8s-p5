package IO::K8s::Api::Core::V1::ContainerImage;
# ABSTRACT: Describe a container image
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s names => [Str];

=attr names

Names by which this image is known. e.g. ["kubernetes.example/hyperkube:v1.0.7", "cloud-vendor.registry.example/cloud-vendor/hyperkube:v1.0.7"]

=cut

k8s sizeBytes => Int;

=attr sizeBytes

The size of the image in bytes.

=cut

1;
