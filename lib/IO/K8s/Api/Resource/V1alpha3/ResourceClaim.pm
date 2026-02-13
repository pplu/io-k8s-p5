package IO::K8s::Api::Resource::V1alpha3::ResourceClaim;
# ABSTRACT: ResourceClaim describes a request for access to resources in the cluster, for use by workloads. For example, if a workload needs an accelerator device with specific properties, this is how that request is expressed. The status stanza tracks whether this claim has been satisfied and what specific resources have been allocated. This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.
our $VERSION = '1.001';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

ResourceClaim describes a request for access to resources in the cluster, for use by workloads. For example, if a workload needs an accelerator device with specific properties, this is how that request is expressed. The status stanza tracks whether this claim has been satisfied and what specific resources have been allocated.

This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Resource::V1alpha3::ResourceClaimSpec', 'required';

=attr spec

Spec describes what is being requested and how to configure it. The spec is immutable.


=cut

k8s status => 'Resource::V1alpha3::ResourceClaimStatus';

=attr status

Status describes whether the claim is ready to use and what has been allocated.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#resourceclaim-v1alpha3-resource.k8s.io>


=cut
1;
