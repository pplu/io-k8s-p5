package IO::K8s::Api::Node::V1::Overhead;
# ABSTRACT: Overhead structure represents the resource overhead associated with running a pod.
our $VERSION = '1.111';
use IO::K8s::Resource;

k8s podFixed => HashRef[Quantity];

=attr podFixed

podFixed represents the fixed resource overhead associated with running a pod.

=cut

1;
