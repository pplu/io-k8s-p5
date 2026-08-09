package IO::K8s::Api::Core::V1::NodeSwapStatus;
# ABSTRACT: NodeSwapStatus represents swap memory information.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s capacity => Int;

=attr capacity

Total amount of swap memory in bytes.

=cut

1;
