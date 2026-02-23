package IO::K8s::Api::Core::V1::TopologySelectorTerm;
# ABSTRACT: A topology selector term represents the result of label queries. A null or empty topology selector term matches no objects. The requirements of them are ANDed. It provides a subset of functionality as NodeSelectorTerm. This is an alpha feature and may change in the future.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s matchLabelExpressions => ['Core::V1::TopologySelectorLabelRequirement'];

=attr matchLabelExpressions

A list of topology selector requirements by labels.

=cut

1;
