package IO::K8s::Traefik::V1alpha1::ServersTransportTCPSpec;
# ABSTRACT: ServersTransportTCPSpec defines the desired state of a ServersTransportTCP.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s dialKeepAlive    => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s dialTimeout      => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s proxyProtocol    => '+IO::K8s::Traefik::V1alpha1::ProxyProtocol';
k8s terminationDelay => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s tls              => '+IO::K8s::Traefik::V1alpha1::TLSClientConfig';

=attr dialKeepAlive

DialKeepAlive is the interval between keep-alive probes for an active network connection. If zero, keep-alive probes are sent with a default value (currently 15 seconds), if supported by the protocol and operating system. Network protocols or operating systems that do not support keep-alives ignore this field. If negative, keep-alive probes are disabled.

=cut

=attr dialTimeout

DialTimeout is the amount of time to wait until a connection to a backend server can be established.

=cut

=attr proxyProtocol

ProxyProtocol holds the PROXY Protocol configuration.

=cut

=attr terminationDelay

TerminationDelay defines the delay to wait before fully terminating the connection, after one connected peer has closed its writing capability.

=cut

=attr tls

TLS defines the TLS configuration

=cut

1;
