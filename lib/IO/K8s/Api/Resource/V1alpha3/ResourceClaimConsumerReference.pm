package IO::K8s::Api::Resource::V1alpha3::ResourceClaimConsumerReference;
# ABSTRACT: ResourceClaimConsumerReference contains enough information to let you locate the consumer of a ResourceClaim. The user must be a resource in the same namespace as the ResourceClaim.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s apiGroup => Str;

=attr apiGroup

APIGroup is the group for the resource being referenced. It is empty for the core API. This matches the group in the APIVersion that is used when creating the resources.

=cut

k8s name => Str, 'required';

=attr name

Name is the name of resource being referenced.

=cut

k8s resource => Str, 'required';

=attr resource

Resource is the type of resource being referenced, for example "pods".

=cut

k8s uid => Str, 'required';

=attr uid

UID identifies exactly one incarnation of the resource.

=cut

1;
