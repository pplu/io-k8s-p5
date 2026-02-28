package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::FieldSelectorRequirement;
# ABSTRACT: FieldSelectorRequirement is a selector that contains values, a key, and an operator that relates the key and values.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s key => Str, 'required';

=attr key

key is the field selector key that the requirement applies to.

=cut

k8s operator => Str, 'required';

=attr operator

operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. The list of operators may grow in the future.

=cut

k8s values => [Str];

=attr values

values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty.

=cut

1;
