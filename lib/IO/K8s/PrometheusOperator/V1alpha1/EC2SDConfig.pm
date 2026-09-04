package IO::K8s::PrometheusOperator::V1alpha1::EC2SDConfig;
# ABSTRACT: EC2SDConfig allow retrieving scrape targets from AWS EC2 instances.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessKey            => 'Core::V1::ConfigMapKeySelector';
k8s enableHTTP2          => Bool;
k8s filters              => ['+IO::K8s::PrometheusOperator::V1alpha1::Filter'];
k8s followRedirects      => Bool;
k8s noProxy              => Str;
k8s port                 => Int, { minimum => 0, maximum => 65535 };
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s refreshInterval      => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s region               => Str;
k8s roleARN              => Str;
k8s secretKey            => 'Core::V1::ConfigMapKeySelector';
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1alpha1::SafeTLSConfig';

=attr accessKey

accessKey defines the AWS API key.

=cut

=attr enableHTTP2

enableHTTP2 defines whether to enable HTTP2.
It requires Prometheus >= v2.41.0

=cut

=attr filters

filters can be used optionally to filter the instance list by other criteria.
Available filter criteria can be found here:
https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html
Filter API documentation: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Filter.html
It requires Prometheus >= v2.3.0

=cut

=attr followRedirects

followRedirects defines whether HTTP requests follow HTTP 3xx redirects.
It requires Prometheus >= v2.41.0

=cut

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr port

port defines the port to scrape metrics from. If using the public IP address, this must
instead be specified in the relabeling rule.

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

region defines the AWS region.

=cut

=attr roleARN

roleARN defines an alternative to using AWS API keys.

=cut

=attr secretKey

secretKey defines the AWS API secret.

=cut

=attr tlsConfig

tlsConfig defines the TLS configuration to connect to the EC2 API.
It requires Prometheus >= v2.41.0

=cut

1;
