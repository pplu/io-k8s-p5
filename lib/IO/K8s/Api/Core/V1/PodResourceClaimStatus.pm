package IO::K8s::Api::Core::V1::PodResourceClaimStatus;
# ABSTRACT: PodResourceClaimStatus is stored in the PodStatus for each PodResourceClaim which references a ResourceClaimTemplate. It stores the generated name for the corresponding ResourceClaim.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name uniquely identifies this resource claim inside the pod. This must match the name of an entry in pod.spec.resourceClaims, which implies that the string must be a DNS_LABEL.

=cut

k8s resourceClaimName => Str;

=attr resourceClaimName

ResourceClaimName is the name of the ResourceClaim that was generated for the Pod in the namespace of the Pod. If this is unset, then generating a ResourceClaim was not necessary. The pod.spec.resourceClaims entry can be ignored in this case.

=cut

1;
