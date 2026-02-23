package IO::K8s::Api::Core::V1::NodeSelectorTerm;
# ABSTRACT: A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s matchExpressions => ['Core::V1::NodeSelectorRequirement'];

=attr matchExpressions

A list of node selector requirements by node's labels.

=cut

k8s matchFields => ['Core::V1::NodeSelectorRequirement'];

=attr matchFields

A list of node selector requirements by node's fields.

=cut

1;
