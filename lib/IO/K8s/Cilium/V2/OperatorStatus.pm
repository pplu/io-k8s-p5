package IO::K8s::Cilium::V2::OperatorStatus;
# ABSTRACT: Operator is the Operator status of the node
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s error => Str;

=attr error

Error is the error message set by cilium-operator.

=cut

1;
