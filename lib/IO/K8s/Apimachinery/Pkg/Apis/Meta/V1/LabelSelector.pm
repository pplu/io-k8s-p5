package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::LabelSelector;
# ABSTRACT: A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s matchExpressions => ['Meta::V1::LabelSelectorRequirement'];

=attr matchExpressions

matchExpressions is a list of label selector requirements. The requirements are ANDed.

=cut

k8s matchLabels => { Str => 1 };

=attr matchLabels

matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is "key", the operator is "In", and the values array contains only "value". The requirements are ANDed.

=cut

1;
