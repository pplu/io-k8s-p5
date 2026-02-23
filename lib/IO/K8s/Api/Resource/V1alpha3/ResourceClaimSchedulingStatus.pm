package IO::K8s::Api::Resource::V1alpha3::ResourceClaimSchedulingStatus;
# ABSTRACT: ResourceClaimSchedulingStatus contains information about one particular ResourceClaim with "WaitForFirstConsumer" allocation mode.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name matches the pod.spec.resourceClaims[*].Name field.

=cut

k8s unsuitableNodes => [Str];

=attr unsuitableNodes

UnsuitableNodes lists nodes that the ResourceClaim cannot be allocated for.

The size of this field is limited to 128, the same as for PodSchedulingSpec.PotentialNodes. This may get increased in the future, but not reduced.

=cut

1;
