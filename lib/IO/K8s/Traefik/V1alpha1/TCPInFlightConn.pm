package IO::K8s::Traefik::V1alpha1::TCPInFlightConn;
# ABSTRACT: InFlightConn defines the InFlightConn middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s amount => Int, { minimum => 0 };

=attr amount

Amount defines the maximum amount of allowed simultaneous connections.
The middleware closes the connection if there are already amount connections opened.

=cut

1;
