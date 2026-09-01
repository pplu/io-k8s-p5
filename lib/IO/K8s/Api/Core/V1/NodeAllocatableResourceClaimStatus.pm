package IO::K8s::Api::Core::V1::NodeAllocatableResourceClaimStatus;
# ABSTRACT: NodeAllocatableResourceClaimStatus tracks the status of node-allocatable resources allocated to a ResourceClaim for a Pod.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s containers => [Str], 'required';

=attr containers

Containers lists the names of the containers in the Pod that use this ResourceClaim to consume node-allocatable resources.

=cut

k8s mapping => ['Core::V1::NodeAllocatableMappedResources'];

=attr mapping

Mapping contains allocations through devices mapped in the device spec's `nodeAllocatableResources[...].mapping` field. This is used by kubelet for pod level and container-level cgroup enforcement.

=cut

k8s overhead => ['Core::V1::NodeAllocatableOverheadResources'];

=attr overhead

Overhead contains allocations through devices mapped in the device spec's `nodeAllocatableResources[...].overhead` field. This is used by kubelet for pod level and container-level cgroup enforcement.

=cut

k8s resourceClaimName => Str, 'required';

=attr resourceClaimName

ResourceClaimName is the name of the ResourceClaim that was generated for the Pod to track allocation of node-allocatable resources.

=cut

k8s resources => { Str => 1 };

=attr resources

Resources lists the node-allocatable resources that were allocated to this ResourceClaim, keyed by resource name.

=cut

1;
