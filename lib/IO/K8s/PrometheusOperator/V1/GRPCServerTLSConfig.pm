package IO::K8s::PrometheusOperator::V1::GRPCServerTLSConfig;
# ABSTRACT: grpcServerTlsConfig defines the TLS parameters for the gRPC server providing the StoreAPI.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ca                 => '+IO::K8s::PrometheusOperator::V1::SecretOrConfigMap';
k8s caFile             => Str;
k8s cert               => '+IO::K8s::PrometheusOperator::V1::SecretOrConfigMap';
k8s certFile           => Str;
k8s cipherSuites       => [Str];
k8s curves             => [Str];
k8s insecureSkipVerify => Bool;
k8s keyFile            => Str;
k8s keySecret          => 'Core::V1::ConfigMapKeySelector';
k8s maxVersion         => Str, { enum => [qw(TLS10 TLS11 TLS12 TLS13)] };
k8s minVersion         => Str, { enum => [qw(TLS10 TLS11 TLS12 TLS13)] };
k8s serverName         => Str;

=attr ca

ca defines the Certificate authority used when verifying server certificates.

=cut

=attr caFile

caFile defines the path to the CA cert in the Prometheus container to use for the targets.

=cut

=attr cert

cert defines the Client certificate to present when doing client-authentication.

=cut

=attr certFile

certFile defines the path to the client cert file in the Prometheus container for the targets.

=cut

=attr cipherSuites

cipherSuites defines the list of supported cipher suites for TLS
versions up to TLS 1.2.

If not defined, the Go default cipher suites are used.
Available cipher suites are documented in the Go documentation:
https://golang.org/pkg/crypto/tls/#pkg-constants

It requires Thanos >= v0.42.0. Note that the operator doesn't verify if
the Thanos version supports the provided values.

=cut

=attr curves

curves defines the list of preferred elliptic curves for
TLS handshakes.

If not defined, the Go default curves are used.
Available curves are documented in the Go documentation:
https://golang.org/pkg/crypto/tls/#CurveID

It requires Thanos >= v0.42.0. Note that the operator doesn't verify if
the Thanos version supports the provided values.

=cut

=attr insecureSkipVerify

insecureSkipVerify defines how to disable target certificate validation.

=cut

=attr keyFile

keyFile defines the path to the client key file in the Prometheus container for the targets.

=cut

=attr keySecret

keySecret defines the Secret containing the client key file for the targets.

=cut

=attr maxVersion

maxVersion defines the maximum acceptable TLS version.

It requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.

=cut

=attr minVersion

minVersion defines the minimum acceptable TLS version.

It requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.

=cut

=attr serverName

serverName is used to verify the hostname for the targets.

=cut

1;
