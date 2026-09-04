package IO::K8s::PrometheusOperator::V1alpha1::DockerSDConfig;
# ABSTRACT: Docker SD configurations allow retrieving scrape targets from Docker Engine hosts.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorization        => '+IO::K8s::PrometheusOperator::V1alpha1::SafeAuthorization';
k8s basicAuth            => '+IO::K8s::PrometheusOperator::V1alpha1::BasicAuth';
k8s enableHTTP2          => Bool;
k8s filters              => ['+IO::K8s::PrometheusOperator::V1alpha1::Filter'];
k8s followRedirects      => Bool;
k8s host                 => Str, { required => 'schema', pattern => qr/^[a-zA-Z][a-zA-Z0-9+.-]*:\/\/.+$/ };
k8s hostNetworkingHost   => Str;
k8s matchFirstNetwork    => Bool;
k8s noProxy              => Str;
k8s oauth2               => '+IO::K8s::PrometheusOperator::V1alpha1::OAuth2';
k8s port                 => Int, { minimum => 0, maximum => 65535 };
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s refreshInterval      => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1alpha1::SafeTLSConfig';

=attr authorization

authorization defines the header configuration to authenticate against the Docker daemon.
Cannot be set at the same time as `oauth2`.

=cut

=attr basicAuth

basicAuth defines information to use on every scrape request.

=cut

=attr enableHTTP2

enableHTTP2 defines whether to enable HTTP2.

=cut

=attr filters

filters defines filters to limit the discovery process to a subset of the available resources.

=cut

=attr followRedirects

followRedirects defines whether HTTP requests follow HTTP 3xx redirects.

=cut

=attr host

host defines the address of the docker daemon.

=cut

=attr hostNetworkingHost

hostNetworkingHost defines the host to use if the container is in host networking mode.

=cut

=attr matchFirstNetwork

matchFirstNetwork defines whether to match the first network if the container has multiple networks defined.
If unset, Prometheus uses true by default.
It requires Prometheus >= v2.54.1.

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

=attr port

port defines the port to scrape metrics from. If using the public IP address, this must

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

=attr tlsConfig

tlsConfig defines the TLS configuration to connect to the Docker daemon.

=cut

1;
