package IO::K8s::PrometheusOperator::V1alpha1::OAuth2;
# ABSTRACT: oauth2 defines the optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientId             => '+IO::K8s::PrometheusOperator::V1alpha1::SecretOrConfigMap', { required => 'schema' };
k8s clientSecret         => 'Core::V1::ConfigMapKeySelector', { required => 'schema' };
k8s endpointParams       => { Str => 1 };
k8s noProxy              => Str;
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s scopes               => [Str];
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1alpha1::SafeTLSConfig';
k8s tokenUrl             => Str, { required => 'schema', pattern => qr/^(http|https):\/\/.+$/ };

=attr clientId

clientId defines a key of a Secret or ConfigMap containing the
OAuth2 client's ID.

=cut

=attr clientSecret

clientSecret defines a key of a Secret containing the OAuth2
client's secret.

=cut

=attr endpointParams

endpointParams configures the HTTP parameters to append to the token
URL.

=cut

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr proxyConnectHeader

proxyConnectHeader optionally specifies headers to send to
proxies during CONNECT requests.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr proxyFromEnvironment

proxyFromEnvironment defines whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr proxyUrl

proxyUrl defines the HTTP proxy server to use.

=cut

=attr scopes

scopes defines the OAuth2 scopes used for the token request.

=cut

=attr tlsConfig

tlsConfig defines the TLS configuration to use when connecting to the OAuth2 server.
It requires Prometheus >= v2.43.0.

=cut

=attr tokenUrl

tokenUrl defines the URL to fetch the token from.

=cut

1;
