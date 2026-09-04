package IO::K8s::PrometheusOperator::V1::APIServerConfig;
# ABSTRACT: apiserverConfig allows specifying a host and auth methods to access the Kuberntees API server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorization        => '+IO::K8s::PrometheusOperator::V1::Authorization';
k8s basicAuth            => '+IO::K8s::PrometheusOperator::V1::BasicAuth';
k8s bearerToken          => Str;
k8s bearerTokenFile      => Str;
k8s host                 => Str, { required => 'schema' };
k8s noProxy              => Str;
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1::TLSConfig';

=attr authorization

authorization section for the API server.

Cannot be set at the same time as `basicAuth`, `bearerToken`, or
`bearerTokenFile`.

=cut

=attr basicAuth

basicAuth configuration for the API server.

Cannot be set at the same time as `authorization`, `bearerToken`, or
`bearerTokenFile`.

=cut

=attr bearerToken

bearerToken is deprecated: this will be removed in a future release.
 *Warning: this field shouldn't be used because the token value appears
in clear-text. Prefer using `authorization`.*

=cut

=attr bearerTokenFile

bearerTokenFile defines the file to read bearer token for accessing apiserver.

Cannot be set at the same time as `basicAuth`, `authorization`, or `bearerToken`.

Deprecated: this will be removed in a future release. Prefer using `authorization`.

=cut

=attr host

host defines the Kubernetes API address consisting of a hostname or IP address followed
by an optional port number.

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

=attr tlsConfig

tlsConfig to use for the API server.

=cut

1;
