package IO::K8s::PrometheusOperator::V1::ProberSpec;
# ABSTRACT: prober defines the specification for the prober to use for probing targets.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s noProxy              => Str;
k8s path                 => Str, { default => '/probe' };
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s scheme               => Str, { enum => [qw(http https HTTP HTTPS)] };
k8s url                  => Str, { required => 'schema' };

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr path

path to collect metrics from.
Defaults to `/probe`.

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

=attr scheme

scheme defines the HTTP scheme to use when scraping the prober.

=cut

=attr url

url defines the address of the prober.

Unlike what the name indicates, the value should be in the form of
`address:port` without any scheme which should be specified in the
`scheme` field.

=cut

1;
