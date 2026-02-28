package IO::K8s::Api::Core::V1::ResourceQuotaSpec;
# ABSTRACT: ResourceQuotaSpec defines the desired hard limits to enforce for Quota.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s hard => { Str => 1 };

=attr hard

hard is the set of desired hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/

=cut

k8s scopeSelector => 'Core::V1::ScopeSelector';

=attr scopeSelector

scopeSelector is also a collection of filters like scopes that must match each object tracked by a quota but expressed using ScopeSelectorOperator in combination with possible values. For a resource to match, both scopes AND scopeSelector (if specified in spec), must be matched.

=cut

k8s scopes => [Str];

=attr scopes

A collection of filters that must match each object tracked by a quota. If not specified, the quota matches all objects.

=cut

1;
