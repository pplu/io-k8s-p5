package IO::K8s::Cilium::V2::PortInfo;
# ABSTRACT: PortInfo specifies L4 port number and name along with the transport protocol
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name     => Str, { pattern => qr/^([0-9]{1,4})|([a-zA-Z0-9]-?)*[a-zA-Z](-?[a-zA-Z0-9])*$/ };
k8s port     => Str, { required => 'schema', pattern => qr/^()([1-9]|[1-5]?[0-9]{2,4}|6[1-4][0-9]{3}|65[1-4][0-9]{2}|655[1-2][0-9]|6553[1-5])$/ };
k8s protocol => Str, { required => 'schema', enum => [qw(TCP UDP)] };

=attr name

Name is a port name, which must contain at least one [a-z],
and may also contain [0-9] and '-' anywhere except adjacent to another
'-' or in the beginning or the end.

=cut

=attr port

Port is an L4 port number. The string will be strictly parsed as a single uint16.

=cut

=attr protocol

Protocol is the L4 protocol.
Accepted values: "TCP", "UDP"

=cut

1;
