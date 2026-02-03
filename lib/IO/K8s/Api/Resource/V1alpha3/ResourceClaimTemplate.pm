package IO::K8s::Api::Resource::V1alpha3::ResourceClaimTemplate;
# ABSTRACT: ResourceClaimTemplate is used to produce ResourceClaim objects. This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

ResourceClaimTemplate is used to produce ResourceClaim objects.

This is an alpha type and requires enabling the DynamicResourceAllocation feature gate.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Resource::V1alpha3::ResourceClaimTemplateSpec', 'required';

=attr spec

Describes the ResourceClaim that is to be generated.

This field is immutable. A ResourceClaim will get created by the control plane for a Pod when needed and then not get updated anymore.

=cut

1;
