package IO::K8s::Api::Core::V1::NodeAddress;
# ABSTRACT: NodeAddress contains information for the node's address.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s address => Str, 'required';

=attr address

The node address.

=cut

k8s type => Str, 'required';

=attr type

Node address type, one of Hostname, ExternalIP or InternalIP.

=cut

1;
