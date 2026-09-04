package IO::K8s::PrometheusOperator::V1::HTTPConfigWithProxy;
# ABSTRACT: httpConfig defines the default HTTP configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorization        => '+IO::K8s::PrometheusOperator::V1::SafeAuthorization';
k8s basicAuth            => '+IO::K8s::PrometheusOperator::V1::BasicAuth';
k8s bearerTokenSecret    => 'Core::V1::ConfigMapKeySelector';
k8s enableHttp2          => Bool;
k8s followRedirects      => Bool;
k8s noProxy              => Str;
k8s oauth2               => '+IO::K8s::PrometheusOperator::V1::OAuth2';
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1::SafeTLSConfig';

=attr authorization

authorization configures the Authorization header credentials used by
the client.

Cannot be set at the same time as `basicAuth`, `bearerTokenSecret` or `oauth2`.

=cut

=attr basicAuth

basicAuth defines the Basic Authentication credentials used by the
client.

Cannot be set at the same time as `authorization`, `bearerTokenSecret` or `oauth2`.

=cut

=attr bearerTokenSecret

bearerTokenSecret defines a key of a Secret containing the bearer token
used by the client for authentication. The secret needs to be in the
same namespace as the custom resource and readable by the Prometheus
Operator.

Cannot be set at the same time as `authorization`, `basicAuth` or `oauth2`.

Deprecated: use `authorization` instead.

=cut

=attr enableHttp2

enableHttp2 can be used to disable HTTP2.

=cut

=attr followRedirects

followRedirects defines whether the client should follow HTTP 3xx
redirects.

=cut

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr oauth2

oauth2 defines the OAuth2 settings used by the client.

It requires Prometheus >= 2.27.0.

Cannot be set at the same time as `authorization`, `basicAuth` or `bearerTokenSecret`.

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

=attr tlsConfig

tlsConfig defines the TLS configuration used by the client.

=cut

1;
