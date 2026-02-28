package IO::K8s::Api::Authorization::V1::ResourceAttributes;
# ABSTRACT: ResourceAttributes includes the authorization attributes available for resource requests to the Authorizer interface
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s fieldSelector => 'Authorization::V1::FieldSelectorAttributes';

=attr fieldSelector

fieldSelector describes the limitation on access based on field.  It can only limit access, not broaden it.

This field  is alpha-level. To use this field, you must enable the `AuthorizeWithSelectors` feature gate (disabled by default).

=cut

k8s group => Str;

=attr group

Group is the API Group of the Resource.  "*" means all.

=cut

k8s labelSelector => 'Authorization::V1::LabelSelectorAttributes';

=attr labelSelector

labelSelector describes the limitation on access based on labels.  It can only limit access, not broaden it.

This field  is alpha-level. To use this field, you must enable the `AuthorizeWithSelectors` feature gate (disabled by default).

=cut

k8s name => Str;

=attr name

Name is the name of the resource being requested for a "get" or deleted for a "delete". "" (empty) means all.

=cut

k8s namespace => Str;

=attr namespace

Namespace is the namespace of the action being requested.  Currently, there is no distinction between no namespace and all namespaces "" (empty) is defaulted for LocalSubjectAccessReviews "" (empty) is empty for cluster-scoped resources "" (empty) means "all" for namespace scoped resources from a SubjectAccessReview or SelfSubjectAccessReview

=cut

k8s resource => Str;

=attr resource

Resource is one of the existing resource types.  "*" means all.

=cut

k8s subresource => Str;

=attr subresource

Subresource is one of the existing resource types.  "" means none.

=cut

k8s verb => Str;

=attr verb

Verb is a kubernetes resource API verb, like: get, list, watch, create, update, delete, proxy.  "*" means all.

=cut

k8s version => Str;

=attr version

Version is the API Version of the Resource.  "*" means all.

=cut

1;
