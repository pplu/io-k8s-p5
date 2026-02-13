package IO::K8s::Api::Resource::V1alpha3::PodSchedulingContextStatus;
# ABSTRACT: PodSchedulingContextStatus describes where resources for the Pod can be allocated.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s resourceClaims => ['Resource::V1alpha3::ResourceClaimSchedulingStatus'];

=attr resourceClaims

ResourceClaims describes resource availability for each pod.spec.resourceClaim entry where the corresponding ResourceClaim uses "WaitForFirstConsumer" allocation mode.

=cut

1;
