package IO::K8s::PrometheusOperator::V1alpha1::NomadSDConfig;
# ABSTRACT: NomadSDConfig configurations allow retrieving scrape targets from Nomad's Service API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allowStale           => Bool;
k8s authorization        => '+IO::K8s::PrometheusOperator::V1alpha1::SafeAuthorization';
k8s basicAuth            => '+IO::K8s::PrometheusOperator::V1alpha1::BasicAuth';
k8s enableHTTP2          => Bool;
k8s followRedirects      => Bool;
k8s namespace            => Str;
k8s noProxy              => Str;
k8s oauth2               => '+IO::K8s::PrometheusOperator::V1alpha1::OAuth2';
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s refreshInterval      => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s region               => Str;
k8s server               => Str, { required => 'schema', pattern => qr/^https?:\/\/.+$/ };
k8s tagSeparator         => Str;
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1alpha1::SafeTLSConfig';

=attr allowStale

allowStale defines the information to access the Nomad API. It is to be defined
as the Nomad documentation requires.

=cut

=attr authorization

authorization defines the header configuration to authenticate against the Nomad API.
Cannot be set at the same time as `oauth2`.

=cut

=attr basicAuth

basicAuth defines information to use on every scrape request.

=cut

=attr enableHTTP2

enableHTTP2 defines whether to enable HTTP2.

=cut

=attr followRedirects

followRedirects defines whether HTTP requests follow HTTP 3xx redirects.

=cut

=attr namespace

namespace defines the Nomad namespace to query for service discovery.
When specified, only resources within this namespace will be discovered.

=cut

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr oauth2

oauth2 defines the configuration to use on every scrape request.

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

=attr refreshInterval

refreshInterval defines the time after which the provided names are refreshed.
If not set, Prometheus uses its default value.

=cut

=attr region

region defines the Nomad region to query for service discovery.
When specified, only resources within this region will be discovered.

=cut

=attr server

server defines the Nomad server address to connect to for service discovery.
This should be the full URL including protocol (e.g., "https://nomad.example.com:4646").

=cut

=attr tagSeparator

tagSeparator defines the separator used to join multiple tags.
This determines how Nomad service tags are concatenated into Prometheus labels.

=cut

=attr tlsConfig

tlsConfig defines the TLS configuration to connect to the Nomad API.

=cut

1;
