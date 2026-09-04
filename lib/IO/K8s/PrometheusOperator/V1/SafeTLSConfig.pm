package IO::K8s::PrometheusOperator::V1::SafeTLSConfig;
# ABSTRACT: tlsConfig defines the TLS configuration to use when connecting to the OAuth2 server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ca                 => '+IO::K8s::PrometheusOperator::V1::SecretOrConfigMap';
k8s cert               => '+IO::K8s::PrometheusOperator::V1::SecretOrConfigMap';
k8s insecureSkipVerify => Bool;
k8s keySecret          => 'Core::V1::ConfigMapKeySelector';
k8s maxVersion         => Str, { enum => [qw(TLS10 TLS11 TLS12 TLS13)] };
k8s minVersion         => Str, { enum => [qw(TLS10 TLS11 TLS12 TLS13)] };
k8s serverName         => Str;

=attr ca

ca defines the Certificate authority used when verifying server certificates.

=cut

=attr cert

cert defines the Client certificate to present when doing client-authentication.

=cut

=attr insecureSkipVerify

insecureSkipVerify defines how to disable target certificate validation.

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
