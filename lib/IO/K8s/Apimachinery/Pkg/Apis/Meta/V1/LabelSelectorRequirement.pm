package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelectorRequirement;
# ABSTRACT: A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s key => Str, 'required';

=attr key

key is the label key that the selector applies to.

=cut

k8s operator => Str, 'required';

=attr operator

operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.

=cut

k8s values => [Str];

=attr values

values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.

=cut

1;
