package IO::K8s::Api::Core::V1::ScopedResourceSelectorRequirement;
# ABSTRACT: A scoped-resource selector requirement is a selector that contains values, a scope name, and an operator that relates the scope name and values.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s operator => Str, 'required';

=attr operator

Represents a scope's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist.

=cut

k8s scopeName => Str, 'required';

=attr scopeName

The name of the scope that the selector applies to.

=cut

k8s values => [Str];

=attr values

An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.

=cut

1;
