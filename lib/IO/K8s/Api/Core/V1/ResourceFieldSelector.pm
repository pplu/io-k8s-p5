package IO::K8s::Api::Core::V1::ResourceFieldSelector;
# ABSTRACT: ResourceFieldSelector represents container resources (cpu, memory) and their output format
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s containerName => Str;

=attr containerName

Container name: required for volumes, optional for env vars

=cut

k8s divisor => Quantity;

=attr divisor

Specifies the output format of the exposed resources, defaults to "1"

=cut

k8s resource => Str, 'required';

=attr resource

Required: resource to select

=cut

1;
