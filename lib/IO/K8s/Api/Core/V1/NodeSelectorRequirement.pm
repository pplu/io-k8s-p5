package IO::K8s::Api::Core::V1::NodeSelectorRequirement;
# ABSTRACT: A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s key => Str, 'required';

=attr key

The label key that the selector applies to.

=cut

k8s operator => Str, 'required';

=attr operator

Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.

=cut

k8s values => [Str];

=attr values

An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.

=cut

1;
