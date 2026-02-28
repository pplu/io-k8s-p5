package IO::K8s::Api::Core::V1::ScopeSelector;
# ABSTRACT: A scope selector represents the AND of the selectors represented by the scoped-resource selector requirements.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s matchExpressions => ['Core::V1::ScopedResourceSelectorRequirement'];

=attr matchExpressions

A list of scope selector requirements by scope of the resources.

=cut

1;
