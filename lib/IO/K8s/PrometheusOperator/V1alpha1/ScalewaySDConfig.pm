package IO::K8s::PrometheusOperator::V1alpha1::ScalewaySDConfig;
# ABSTRACT: ScalewaySDConfig configurations allow retrieving scrape targets from Scaleway instances and baremetal services.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessKey            => Str, { required => 'schema' };
k8s apiURL               => Str, { pattern => qr/^https?:\/\/.+$/ };
k8s enableHTTP2          => Bool;
k8s followRedirects      => Bool;
k8s nameFilter           => Str;
k8s noProxy              => Str;
k8s port                 => Int, { minimum => 0, maximum => 65535 };
k8s projectID            => Str, { required => 'schema' };
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s refreshInterval      => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s role                 => Str, { required => 'schema', enum => [qw(Instance Baremetal)] };
k8s secretKey            => 'Core::V1::ConfigMapKeySelector', { required => 'schema' };
k8s tagsFilter           => [Str];
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1alpha1::SafeTLSConfig';
k8s zone                 => Str;

=attr accessKey

accessKey defines the access key to use. https://console.scaleway.com/project/credentials

=cut

=attr apiURL

apiURL defines the API URL to use when doing the server listing requests.

=cut

=attr enableHTTP2

enableHTTP2 defines whether to enable HTTP2.

=cut

=attr followRedirects

followRedirects defines whether HTTP requests follow HTTP 3xx redirects.

=cut

=attr nameFilter

nameFilter defines a name filter (works as a LIKE) to apply on the server listing request.

=cut

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr port

port defines the port to scrape metrics from. If using the public IP address, this must

=cut

=attr projectID

projectID defines the Project ID of the targets.

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

=attr role

role defines the service of the targets to retrieve. Must be `Instance` or `Baremetal`.

=cut

=attr secretKey

secretKey defines the secret key to use when listing targets.

=cut

=attr tagsFilter

tagsFilter defines a tag filter (a server needs to have all defined tags to be listed) to apply on the server listing request.

=cut

=attr tlsConfig

tlsConfig defines the TLS configuration to connect to the Scaleway API.

=cut

=attr zone

zone defines the availability zone of your targets (e.g. fr-par-1).

=cut

1;
