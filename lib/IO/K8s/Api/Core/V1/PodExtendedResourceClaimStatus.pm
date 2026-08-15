package IO::K8s::Api::Core::V1::PodExtendedResourceClaimStatus;
# ABSTRACT: PodExtendedResourceClaimStatus is stored in the PodStatus for the extended resources backed by DRA. It stores the generated name for the corresponding special ResourceClaim created by the scheduler.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s requestMappings => ['Core::V1::ContainerExtendedResourceRequest'], 'required';

=attr requestMappings

RequestMappings identifies the mapping of extended resource requests in each container to their corresponding requests within the special ResourceClaim.

=cut

k8s resourceClaimName => Str, 'required';

=attr resourceClaimName

ResourceClaimName is the name of the ResourceClaim that was generated for the Pod in the namespace of the Pod.

=cut

1;
