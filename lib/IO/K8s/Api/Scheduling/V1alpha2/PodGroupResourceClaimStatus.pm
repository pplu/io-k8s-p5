package IO::K8s::Api::Scheduling::V1alpha2::PodGroupResourceClaimStatus;
# ABSTRACT: PodGroupResourceClaimStatus is stored in the PodGroupStatus for each PodGroupResourceClaim which references a ResourceClaimTemplate. It stores the generated name for the corresponding ResourceClaim.
our $VERSION = '1.105';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name uniquely identifies this resource claim inside the PodGroup. This must match the name of an entry in podgroup.spec.resourceClaims, which implies that the string must be a DNS_LABEL.

=cut

k8s resourceClaimName => Str;

=attr resourceClaimName

ResourceClaimName is the name of the ResourceClaim that was generated for the PodGroup in the namespace of the PodGroup. If this is unset, then generating a ResourceClaim was not necessary. The podgroup.spec.resourceClaims entry can be ignored in this case.

=cut

1;
