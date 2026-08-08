package IO::K8s::Api::Scheduling::V1alpha2::PodGroupResourceClaim;
# ABSTRACT: PodGroupResourceClaim references exactly one ResourceClaim, either directly or by naming a ResourceClaimTemplate which is then turned into a ResourceClaim for the PodGroup.
our $VERSION = '1.106';
use IO::K8s::Resource;

=description

PodGroupResourceClaim references exactly one ResourceClaim, either directly or by naming a ResourceClaimTemplate which is then turned into a ResourceClaim for the PodGroup.

It adds a name to it that uniquely identifies the ResourceClaim inside the PodGroup. Pods that need access to the ResourceClaim define a matching reference in its own Spec.ResourceClaims. The Pod's claim must match all fields of the PodGroup's claim exactly.

=cut


k8s name => Str, 'required';

=attr name

Name uniquely identifies this resource claim inside the PodGroup. This must be a DNS_LABEL.

=cut

k8s resourceClaimName => Str;

=attr resourceClaimName

ResourceClaimName is the name of a ResourceClaim object in the same namespace as this PodGroup. The ResourceClaim will be reserved for the PodGroup instead of its individual pods.

Exactly one of ResourceClaimName and ResourceClaimTemplateName must be set.

=cut

k8s resourceClaimTemplateName => Str;

=attr resourceClaimTemplateName

ResourceClaimTemplateName is the name of a ResourceClaimTemplate object in the same namespace as this PodGroup.

The template will be used to create a new ResourceClaim, which will be bound to this PodGroup. When this PodGroup is deleted, the ResourceClaim will also be deleted. The PodGroup name and resource name, along with a generated component, will be used to form a unique name for the ResourceClaim, which will be recorded in podgroup.status.resourceClaimStatuses.

This field is immutable and no changes will be made to the corresponding ResourceClaim by the control plane after creating the ResourceClaim.

Exactly one of ResourceClaimName and ResourceClaimTemplateName must be set.

=cut

1;
