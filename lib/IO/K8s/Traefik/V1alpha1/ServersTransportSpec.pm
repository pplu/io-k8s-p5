package IO::K8s::Traefik::V1alpha1::ServersTransportSpec;
# ABSTRACT: ServersTransportSpec defines the desired state of a ServersTransport.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s certificatesSecrets => [Str];
k8s cipherSuites        => [Str];
k8s disableHTTP2        => Bool;
k8s forwardingTimeouts  => '+IO::K8s::Traefik::V1alpha1::ForwardingTimeouts';
k8s insecureSkipVerify  => Bool;
k8s maxIdleConnsPerHost => Int, { minimum => -1 };
k8s maxVersion          => Str;
k8s minVersion          => Str;
k8s peerCertURI         => Str;
k8s rootCAs             => ['+IO::K8s::Traefik::V1alpha1::RootCA'];
k8s rootCAsSecrets      => [Str];
k8s serverName          => Str;
k8s spiffe              => '+IO::K8s::Traefik::V1alpha1::Spiffe';

=attr certificatesSecrets

CertificatesSecrets defines a list of secret storing client certificates for mTLS.

=cut

=attr cipherSuites

CipherSuites defines the cipher suites to use when contacting backend servers.

=cut

=attr disableHTTP2

DisableHTTP2 disables HTTP/2 for connections with backend servers.

=cut

=attr forwardingTimeouts

ForwardingTimeouts defines the timeouts for requests forwarded to the backend servers.

=cut

=attr insecureSkipVerify

InsecureSkipVerify disables SSL certificate verification.

=cut

=attr maxIdleConnsPerHost

MaxIdleConnsPerHost controls the maximum idle (keep-alive) to keep per-host.

=cut

=attr maxVersion

MaxVersion defines the maximum TLS version to use when contacting backend servers.

=cut

=attr minVersion

MinVersion defines the minimum TLS version to use when contacting backend servers.

=cut

=attr peerCertURI

PeerCertURI defines the peer cert URI used to match against SAN URI during the peer certificate verification.

=cut

=attr rootCAs

RootCAs defines a list of CA certificate Secrets or ConfigMaps used to validate server certificates.

=cut

=attr rootCAsSecrets

RootCAsSecrets defines a list of CA secret used to validate self-signed certificate.

Deprecated: RootCAsSecrets is deprecated, please use the RootCAs option instead.

=cut

=attr serverName

ServerName defines the server name used to contact the server.

=cut

=attr spiffe

Spiffe defines the SPIFFE configuration.

=cut

1;
