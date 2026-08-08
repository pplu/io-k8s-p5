package IO::K8s::Api::Discovery::V1::ForNode;
# ABSTRACT: ForNode provides information about which nodes should consume this endpoint.
our $VERSION = '1.105';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

name represents the name of the node.

=cut

1;
