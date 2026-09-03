package IO::K8s::Traefik::V1alpha1::TLSClientConfig;
# ABSTRACT: TLS defines the TLS configuration
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s certificatesSecrets => [Str];
k8s insecureSkipVerify  => Bool;
k8s peerCertURI         => Str;
k8s rootCAs             => ['+IO::K8s::Traefik::V1alpha1::RootCA'];
k8s rootCAsSecrets      => [Str];
k8s serverName          => Str;
k8s spiffe              => '+IO::K8s::Traefik::V1alpha1::Spiffe';

=attr certificatesSecrets

CertificatesSecrets defines a list of secret storing client certificates for mTLS.

=cut

=attr insecureSkipVerify

InsecureSkipVerify disables TLS certificate verification.

=cut

=attr peerCertURI

MaxIdleConnsPerHost controls the maximum idle (keep-alive) to keep per-host.
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
