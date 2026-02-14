package IO::K8s::Api::Core::V1::NodeSelector;
# ABSTRACT: A node selector represents the union of the results of one or more label queries over a set of nodes; that is, it represents the OR of the selectors represented by the node selector terms.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s nodeSelectorTerms => ['Core::V1::NodeSelectorTerm'], 'required';

=attr nodeSelectorTerms

Required. A list of node selector terms. The terms are ORed.

=cut

1;
