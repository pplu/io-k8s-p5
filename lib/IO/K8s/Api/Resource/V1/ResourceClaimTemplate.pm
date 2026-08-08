package IO::K8s::Api::Resource::V1::ResourceClaimTemplate;
# ABSTRACT: ResourceClaimTemplate is used to produce ResourceClaim objects.
our $VERSION = '1.106';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

ResourceClaimTemplate is used to produce ResourceClaim objects.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Resource::V1::ResourceClaimTemplateSpec', 'required';

=attr spec

Describes the ResourceClaim that is to be generated.

This field is immutable. A ResourceClaim will get created by the control plane for a Pod when needed and then not get updated anymore.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.36/#resourceclaimtemplate-v1-resource.k8s.io>


=cut
1;
