package IO::K8s::PrometheusOperator::V1::ProbeSpec;
# ABSTRACT: spec defines the specification of desired Ingress selection for target discovery by Prometheus.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorization                  => '+IO::K8s::PrometheusOperator::V1::SafeAuthorization';
k8s basicAuth                      => '+IO::K8s::PrometheusOperator::V1::BasicAuth';
k8s bearerTokenSecret              => 'Core::V1::ConfigMapKeySelector';
k8s convertClassicHistogramsToNHCB => Bool;
k8s enableHttp2                    => Bool;
k8s fallbackScrapeProtocol         => Str, { enum => [qw(PrometheusProto OpenMetricsText0.0.1 OpenMetricsText1.0.0 PrometheusText0.0.4 PrometheusText1.0.0)] };
k8s followRedirects                => Bool;
k8s interval                       => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s jobName                        => Str;
k8s keepDroppedTargets             => Int, { minimum => 0 };
k8s labelLimit                     => Int, { minimum => 0 };
k8s labelNameLengthLimit           => Int, { minimum => 0 };
k8s labelValueLengthLimit          => Int, { minimum => 0 };
k8s metricRelabelings              => ['+IO::K8s::PrometheusOperator::V1::RelabelConfig'];
k8s module                         => Str;
k8s nativeHistogramBucketLimit     => Int, { minimum => 0 };
k8s nativeHistogramMinBucketFactor => IntOrStr, { pattern => qr/^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$/ };
k8s oauth2                         => '+IO::K8s::PrometheusOperator::V1::OAuth2';
k8s params                         => ['+IO::K8s::PrometheusOperator::V1::ProbeParam'];
k8s prober                         => '+IO::K8s::PrometheusOperator::V1::ProberSpec';
k8s sampleLimit                    => Int, { minimum => 0 };
k8s scrapeClass                    => Str;
k8s scrapeClassicHistograms        => Bool;
k8s scrapeNativeHistograms         => Bool;
k8s scrapeProtocols                => [Str], { enum => [qw(PrometheusProto OpenMetricsText0.0.1 OpenMetricsText1.0.0 PrometheusText0.0.4 PrometheusText1.0.0)] };
k8s scrapeTimeout                  => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s targetLimit                    => Int, { minimum => 0 };
k8s targets                        => '+IO::K8s::PrometheusOperator::V1::ProbeTargets';
k8s tlsConfig                      => '+IO::K8s::PrometheusOperator::V1::SafeTLSConfig';

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

=attr convertClassicHistogramsToNHCB

convertClassicHistogramsToNHCB defines whether to convert all scraped classic histograms into a native histogram with custom buckets.
It requires Prometheus >= v3.0.0.

=cut

=attr enableHttp2

enableHttp2 can be used to disable HTTP2.

=cut

=attr fallbackScrapeProtocol

fallbackScrapeProtocol defines the protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.

It requires Prometheus >= v3.0.0.

=cut

=attr followRedirects

followRedirects defines whether the client should follow HTTP 3xx
redirects.

=cut

=attr interval

interval at which targets are probed using the configured prober.
If not specified Prometheus' global scrape interval is used.

=cut

=attr jobName

jobName assigned to scraped metrics by default.

=cut

=attr keepDroppedTargets

keepDroppedTargets defines the per-scrape limit on the number of targets dropped by relabeling
that will be kept in memory. 0 means no limit.

It requires Prometheus >= v2.47.0.

=cut

=attr labelLimit

labelLimit defines the per-scrape limit on number of labels that will be accepted for a sample.
Only valid in Prometheus versions 2.27.0 and newer.

=cut

=attr labelNameLengthLimit

labelNameLengthLimit defines the per-scrape limit on length of labels name that will be accepted for a sample.
Only valid in Prometheus versions 2.27.0 and newer.

=cut

=attr labelValueLengthLimit

labelValueLengthLimit defines the per-scrape limit on length of labels value that will be accepted for a sample.
Only valid in Prometheus versions 2.27.0 and newer.

=cut

=attr metricRelabelings

metricRelabelings defines the RelabelConfig to apply to samples before ingestion.

=cut

=attr module

module to use for probing specifying how to probe the target.
Example module configuring in the blackbox exporter:
https://github.com/prometheus/blackbox_exporter/blob/master/example.yml

=cut

=attr nativeHistogramBucketLimit

nativeHistogramBucketLimit defines ff there are more than this many buckets in a native histogram,
buckets will be merged to stay within the limit.
It requires Prometheus >= v2.45.0.

=cut

=attr nativeHistogramMinBucketFactor

nativeHistogramMinBucketFactor defines if the growth factor of one bucket to the next is smaller than this,
buckets will be merged to increase the factor sufficiently.
It requires Prometheus >= v2.50.0.

=cut

=attr oauth2

oauth2 defines the OAuth2 settings used by the client.

It requires Prometheus >= 2.27.0.

Cannot be set at the same time as `authorization`, `basicAuth` or `bearerTokenSecret`.

=cut

=attr params

params defines the list of HTTP query parameters for the scrape.
Please note that the `.spec.module` field takes precedence over the `module` parameter from this list when both are defined.
The module name must be added using Module under ProbeSpec.

=cut

=attr prober

prober defines the specification for the prober to use for probing targets.
The prober.URL parameter is required. Targets cannot be probed if left empty.

=cut

=attr sampleLimit

sampleLimit defines per-scrape limit on number of scraped samples that will be accepted.

=cut

=attr scrapeClass

scrapeClass defines the scrape class to apply.

=cut

=attr scrapeClassicHistograms

scrapeClassicHistograms defines whether to scrape a classic histogram that is also exposed as a native histogram.
It requires Prometheus >= v2.45.0.

Notice: `scrapeClassicHistograms` corresponds to the `always_scrape_classic_histograms` field in the Prometheus configuration.

=cut

=attr scrapeNativeHistograms

scrapeNativeHistograms defines whether to enable scraping of native histograms.
It requires Prometheus >= v3.8.0.

=cut

=attr scrapeProtocols

scrapeProtocols defines the protocols to negotiate during a scrape. It tells clients the
protocols supported by Prometheus in order of preference (from most to least preferred).

If unset, Prometheus uses its default value.

It requires Prometheus >= v2.49.0.

=cut

=attr scrapeTimeout

scrapeTimeout defines the timeout for scraping metrics from the Prometheus exporter.
If not specified, the Prometheus global scrape timeout is used.
The value cannot be greater than the scrape interval otherwise the operator will reject the resource.

=cut

=attr targetLimit

targetLimit defines a limit on the number of scraped targets that will be accepted.

=cut

=attr targets

targets defines a set of static or dynamically discovered targets to probe.

=cut

=attr tlsConfig

tlsConfig defines the TLS configuration used by the client.

=cut

1;
