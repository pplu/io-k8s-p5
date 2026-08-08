package IO::K8s::Api::Core::V1::ContainerExtendedResourceRequest;
# ABSTRACT: ContainerExtendedResourceRequest has the mapping of container name, extended resource name to the device request name.
our $VERSION = '1.101';
use IO::K8s::Resource;

k8s containerName => Str, 'required';

=attr containerName

The name of the container requesting resources, referring to a container in the pod's containers or initContainers list.

=cut

k8s requestName => Str, 'required';

=attr requestName

The name of the request in the special ResourceClaim which corresponds to the extended resource.

=cut

k8s resourceName => Str, 'required';

=attr resourceName

The name of the extended resource in that container which gets backed by DRA.

=cut

1;
