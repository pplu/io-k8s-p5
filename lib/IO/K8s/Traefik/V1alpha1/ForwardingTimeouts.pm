package IO::K8s::Traefik::V1alpha1::ForwardingTimeouts;
# ABSTRACT: ForwardingTimeouts defines the timeouts for requests forwarded to the backend servers.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s dialTimeout           => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s idleConnTimeout       => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s pingTimeout           => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s readIdleTimeout       => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s responseHeaderTimeout => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };

=attr dialTimeout

DialTimeout is the amount of time to wait until a connection to a backend server can be established.

=cut

=attr idleConnTimeout

IdleConnTimeout is the maximum period for which an idle HTTP keep-alive connection will remain open before closing itself.

=cut

=attr pingTimeout

PingTimeout is the timeout after which the HTTP/2 connection will be closed if a response to ping is not received.

=cut

=attr readIdleTimeout

ReadIdleTimeout is the timeout after which a health check using ping frame will be carried out if no frame is received on the HTTP/2 connection.

=cut

=attr responseHeaderTimeout

ResponseHeaderTimeout is the amount of time to wait for a server's response headers after fully writing the request (including its body, if any).

=cut

1;
