package IO::K8s::PrometheusOperator::V1::AlertmanagerEndpoints;
# ABSTRACT: AlertmanagerEndpoints defines a selection of a single Endpoints object containing Alertmanager IPs to fire alerts against.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s alertRelabelings     => ['+IO::K8s::PrometheusOperator::V1::RelabelConfig'];
k8s apiVersion           => Str, { enum => [qw(v1 V1 v2 V2)] };
k8s authorization        => '+IO::K8s::PrometheusOperator::V1::SafeAuthorization';
k8s basicAuth            => '+IO::K8s::PrometheusOperator::V1::BasicAuth';
k8s bearerTokenFile      => Str;
k8s enableHttp2          => Bool;
k8s name                 => Str, { required => 'schema' };
k8s namespace            => Str;
k8s noProxy              => Str;
k8s pathPrefix           => Str;
k8s port                 => IntOrStr, { required => 'schema' };
k8s proxyConnectHeader   => { Str => 1 };
k8s proxyFromEnvironment => Bool;
k8s proxyUrl             => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s relabelings          => ['+IO::K8s::PrometheusOperator::V1::RelabelConfig'];
k8s scheme               => Str, { enum => [qw(http https HTTP HTTPS)] };
k8s sigv4                => '+IO::K8s::PrometheusOperator::V1::Sigv4';
k8s timeout              => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s tlsConfig            => '+IO::K8s::PrometheusOperator::V1::TLSConfig';

=attr alertRelabelings

alertRelabelings defines the relabeling configs applied before sending alerts to a specific Alertmanager.
It requires Prometheus >= v2.51.0.

=cut

=attr apiVersion

apiVersion defines the version of the Alertmanager API that Prometheus uses to send alerts.
It can be "V1" or "V2".
The field has no effect for Prometheus >= v3.0.0 because only the v2 API is supported.

=cut

=attr authorization

authorization section for Alertmanager.

Cannot be set at the same time as `basicAuth`, `bearerTokenFile` or `sigv4`.

=cut

=attr basicAuth

basicAuth configuration for Alertmanager.

Cannot be set at the same time as `bearerTokenFile`, `authorization` or `sigv4`.

=cut

=attr bearerTokenFile

bearerTokenFile defines the file to read bearer token for Alertmanager.

Cannot be set at the same time as `basicAuth`, `authorization`, or `sigv4`.

Deprecated: this will be removed in a future release. Prefer using `authorization`.

=cut

=attr enableHttp2

enableHttp2 defines whether to enable HTTP2.

=cut

=attr name

name of the Endpoints object in the namespace.

=cut

=attr namespace

namespace of the Endpoints object.

If not set, the object will be discovered in the namespace of the
Prometheus object.

=cut

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr pathPrefix

pathPrefix defines the prefix for the HTTP path alerts are pushed to.

=cut

=attr port

port on which the Alertmanager API is exposed.

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

=attr relabelings

relabelings defines the relabel configuration applied to the discovered Alertmanagers.

=cut

=attr scheme

scheme defines the HTTP scheme to use when sending alerts.

=cut

=attr sigv4

sigv4 defines AWS's Signature Verification 4 for the URL.

It requires Prometheus >= v2.48.0.

Cannot be set at the same time as `basicAuth`, `bearerTokenFile` or `authorization`.

=cut

=attr timeout

timeout defines a per-target Alertmanager timeout when pushing alerts.

=cut

=attr tlsConfig

tlsConfig to use for Alertmanager.

=cut

1;
