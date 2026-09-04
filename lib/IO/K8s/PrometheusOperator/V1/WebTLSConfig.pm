package IO::K8s::PrometheusOperator::V1::WebTLSConfig;
# ABSTRACT: tlsConfig defines the TLS parameters for HTTPS.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cert                     => '+IO::K8s::PrometheusOperator::V1::SecretOrConfigMap';
k8s certFile                 => Str;
k8s cipherSuites             => [Str];
k8s clientAuthType           => Str;
k8s clientCAFile             => Str;
k8s client_ca                => '+IO::K8s::PrometheusOperator::V1::SecretOrConfigMap';
k8s curvePreferences         => [Str];
k8s keyFile                  => Str;
k8s keySecret                => 'Core::V1::ConfigMapKeySelector';
k8s maxVersion               => Str;
k8s minVersion               => Str;
k8s preferServerCipherSuites => Bool;

=attr cert

cert defines the Secret or ConfigMap containing the TLS certificate for the web server.

Either `keySecret` or `keyFile` must be defined.

It is mutually exclusive with `certFile`.

=cut

=attr certFile

certFile defines the path to the TLS certificate file in the container for the web server.

Either `keySecret` or `keyFile` must be defined.

It is mutually exclusive with `cert`.

=cut

=attr cipherSuites

cipherSuites defines the list of supported cipher suites for TLS versions up to TLS 1.2.

If not defined, the Go default cipher suites are used.
Available cipher suites are documented in the Go documentation:
https://golang.org/pkg/crypto/tls/#pkg-constants

=cut

=attr clientAuthType

clientAuthType defines the server policy for client TLS authentication.

For more detail on clientAuth options:
https://golang.org/pkg/crypto/tls/#ClientAuthType

=cut

=attr clientCAFile

clientCAFile defines the path to the CA certificate file for client certificate authentication to
the server.

It is mutually exclusive with `client_ca`.

=cut

=attr client_ca

client_ca defines the Secret or ConfigMap containing the CA certificate for client certificate
authentication to the server.

It is mutually exclusive with `clientCAFile`.

=cut

=attr curvePreferences

curvePreferences defines elliptic curves that will be used in an ECDHE handshake, in preference
order.

Available curves are documented in the Go documentation:
https://golang.org/pkg/crypto/tls/#CurveID

=cut

=attr keyFile

keyFile defines the path to the TLS private key file in the container for the web server.

If defined, either `cert` or `certFile` must be defined.

It is mutually exclusive with `keySecret`.

=cut

=attr keySecret

keySecret defines the secret containing the TLS private key for the web server.

Either `cert` or `certFile` must be defined.

It is mutually exclusive with `keyFile`.

=cut

=attr maxVersion

maxVersion defines the Maximum TLS version that is acceptable.

=cut

=attr minVersion

minVersion defines the minimum TLS version that is acceptable.

=cut

=attr preferServerCipherSuites

preferServerCipherSuites defines whether the server selects the client's most preferred cipher
suite, or the server's most preferred cipher suite.

If true then the server's preference, as expressed in
the order of elements in cipherSuites, is used.

=cut

1;
