package IO::K8s::PrometheusOperator::V1::RemoteReadSpec;
# ABSTRACT: RemoteReadSpec defines the configuration for Prometheus to read back samples from a remote endpoint.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorization        => '+IO::K8s::PrometheusOperator::V1::Authorization';
k8s basicAuth            => '+IO::K8s::PrometheusOperator::V1::BasicAuth';
k8s bearerToken          => Str;
k8s bearerTokenFile      => Str;
k8s filterExternalLabels => Bool;
k8s followRedirects      => Bool;
k8s headers              => { Str => 1 };
k8s name                 => Str;
k8s noProxy              => Str;
k8s oauth2               => '+IO::K8s::PrometheusOperator::V1::OAuth2';
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s readRecent           => Bool;
k8s remoteTimeout        => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s requiredMatchers     => { Str => 1 };
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1::TLSConfig';
k8s url                  => Str, { required => 'schema', pattern => qr/^(http|https):\/\/.+$/ };

=attr authorization

authorization section for the URL.

It requires Prometheus >= v2.26.0.

Cannot be set at the same time as `basicAuth`, or `oauth2`.

=cut

=attr basicAuth

basicAuth configuration for the URL.

Cannot be set at the same time as `authorization`, or `oauth2`.

=cut

=attr bearerToken

bearerToken is deprecated: this will be removed in a future release.
*Warning: this field shouldn't be used because the token value appears
in clear-text. Prefer using `authorization`.*

=cut

=attr bearerTokenFile

bearerTokenFile defines the file from which to read the bearer token for the URL.

Deprecated: this will be removed in a future release. Prefer using `authorization`.

=cut

=attr filterExternalLabels

filterExternalLabels defines whether to use the external labels as selectors for the remote read endpoint.

It requires Prometheus >= v2.34.0.

=cut

=attr followRedirects

followRedirects defines whether HTTP requests follow HTTP 3xx redirects.

It requires Prometheus >= v2.26.0.

=cut

=attr headers

headers defines the custom HTTP headers to be sent along with each remote read request.
Be aware that headers that are set by Prometheus itself can't be overwritten.
Only valid in Prometheus versions 2.26.0 and newer.

=cut

=attr name

name of the remote read queue, it must be unique if specified. The
name is used in metrics and logging in order to differentiate read
configurations.

It requires Prometheus >= v2.15.0.

=cut

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr oauth2

oauth2 configuration for the URL.

It requires Prometheus >= v2.27.0.

Cannot be set at the same time as `authorization`, or `basicAuth`.

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

=attr readRecent

readRecent defines whether reads should be made for queries for time ranges that
the local storage should have complete data for.

=cut

=attr remoteTimeout

remoteTimeout defines the timeout for requests to the remote read endpoint.

=cut

=attr requiredMatchers

requiredMatchers defines an optional list of equality matchers which have to be present
in a selector to query the remote read endpoint.

=cut

=attr tlsConfig

tlsConfig to use for the URL.

=cut

=attr url

url defines the URL of the endpoint to query from.

It must use the HTTP or HTTPS scheme.

=cut

1;
