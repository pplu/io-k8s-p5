package IO::K8s::Api::Core::V1::TCPSocketAction;
# ABSTRACT: TCPSocketAction describes an action based on opening a socket
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s host => Str;

=attr host

Optional: Host name to connect to, defaults to the pod IP.

=cut

k8s port => Str, 'required';

=attr port

Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.

=cut

1;
