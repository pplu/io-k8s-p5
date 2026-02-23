package IO::K8s::Api::Node::V1::Overhead;
# ABSTRACT: Overhead structure represents the resource overhead associated with running a pod.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s podFixed => { Str => 1 };

=attr podFixed

podFixed represents the fixed resource overhead associated with running a pod.

=cut

1;
