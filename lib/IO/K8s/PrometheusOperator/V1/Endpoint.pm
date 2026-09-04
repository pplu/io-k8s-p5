package IO::K8s::PrometheusOperator::V1::Endpoint;
# ABSTRACT: Endpoint defines an endpoint serving Prometheus metrics to be scraped by Prometheus.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorization            => '+IO::K8s::PrometheusOperator::V1::SafeAuthorization';
k8s basicAuth                => '+IO::K8s::PrometheusOperator::V1::BasicAuth';
k8s bearerTokenFile          => Str;
k8s bearerTokenSecret        => 'Core::V1::ConfigMapKeySelector';
k8s enableHttp2              => Bool;
k8s filterRunning            => Bool;
k8s followRedirects          => Bool;
k8s honorLabels              => Bool;
k8s honorTimestamps          => Bool;
k8s interval                 => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s metricRelabelings        => ['+IO::K8s::PrometheusOperator::V1::RelabelConfig'];
k8s noProxy                  => Str;
k8s oauth2                   => '+IO::K8s::PrometheusOperator::V1::OAuth2';
k8s params                   => { Str => 1 };
k8s path                     => Str;
k8s port                     => Str;
k8s proxyConnectHeader       => { Str => 1 };
k8s proxyFromEnvironment     => Bool;
k8s proxyUrl                 => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s relabelings              => ['+IO::K8s::PrometheusOperator::V1::RelabelConfig'];
k8s scheme                   => Str, { enum => [qw(http https HTTP HTTPS)] };
k8s scrapeTimeout            => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s targetPort               => IntOrStr;
k8s tlsConfig                => '+IO::K8s::PrometheusOperator::V1::TLSConfig';
k8s trackTimestampsStaleness => Bool;

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

=attr bearerTokenFile

bearerTokenFile defines the file to read bearer token for scraping the target.

Deprecated: use `authorization` instead.

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

=attr filterRunning

filterRunning when true, the pods which are not running (e.g. either in Failed or
Succeeded state) are dropped during the target discovery.

If unset, the filtering is enabled.

More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase

=cut

=attr followRedirects

followRedirects defines whether the client should follow HTTP 3xx
redirects.

=cut

=attr honorLabels

honorLabels defines when true the metric's labels when they collide
with the target's labels.

=cut

=attr honorTimestamps

honorTimestamps defines whether Prometheus preserves the timestamps
when exposed by the target.

=cut

=attr interval

interval at which Prometheus scrapes the metrics from the target.

If empty, Prometheus uses the global scrape interval.

=cut

=attr metricRelabelings

metricRelabelings defines the relabeling rules to apply to the
samples before ingestion.

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

=attr params

params define optional HTTP URL parameters.

=cut

=attr path

path defines the HTTP path from which to scrape for metrics.

If empty, Prometheus uses the default value (e.g. `/metrics`).

=cut

=attr port

port defines the name of the Service port which this endpoint refers to
(e.g. `.spec.ports[].name`).

It takes precedence over `targetPort`.

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

relabelings defines the relabeling rules to apply the target's
metadata labels.

The Operator automatically adds relabelings for a few standard Kubernetes fields.

The original scrape job's name is available via the `__tmp_prometheus_job_name` label.

More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config

=cut

=attr scheme

scheme defines the HTTP scheme to use when scraping the metrics.

=cut

=attr scrapeTimeout

scrapeTimeout defines the timeout after which Prometheus considers the scrape to be failed.

If empty, Prometheus uses the global scrape timeout unless it is less
than the target's scrape interval value in which the latter is used.
The value cannot be greater than the scrape interval otherwise the operator will reject the resource.

=cut

=attr targetPort

targetPort defines the name or number of a container port on Pods selected
by the Service.
If a name, it matches against `.spec.containers[].ports[].name` of the Pods.
If a number, it matches against `.spec.containers[].ports[].containerPort` of the Pods.

=cut

=attr tlsConfig

tlsConfig defines TLS configuration used by the client.

=cut

=attr trackTimestampsStaleness

trackTimestampsStaleness defines whether Prometheus tracks staleness of
the metrics that have an explicit timestamp present in scraped data.
Has no effect if `honorTimestamps` is false.

It requires Prometheus >= v2.48.0.

=cut

1;
