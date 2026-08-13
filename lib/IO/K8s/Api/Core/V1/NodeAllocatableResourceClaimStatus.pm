package IO::K8s::Api::Core::V1::NodeAllocatableResourceClaimStatus;
# ABSTRACT: NodeAllocatableResourceClaimStatus tracks the status of node-allocatable resources allocated to a ResourceClaim for a Pod.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s containers => [Str], 'required';

=attr containers

Containers lists the names of the containers in the Pod that use this ResourceClaim to consume node-allocatable resources.

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
