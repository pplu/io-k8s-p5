package IO::K8s::Api::Resource::V1beta1::ResourceClaimTemplateSpec;
# ABSTRACT: ResourceClaimTemplateSpec contains the metadata and fields for a ResourceClaim.
our $VERSION = '1.108';
use IO::K8s::APIObject;

=description

ResourceClaimTemplateSpec contains the metadata and fields for a ResourceClaim.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.

=cut

k8s spec => 'Resource::V1beta1::ResourceClaimSpec', 'required';

=attr spec

Spec for the ResourceClaim. The entire content is copied unchanged into the ResourceClaim that gets created from this template. The same fields as in a ResourceClaim are also valid here.

=cut

1;
