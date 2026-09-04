package IO::K8s::PrometheusOperator::V1alpha1::ScrapeConfigSpec;
# ABSTRACT: spec defines the specification of ScrapeConfigSpec.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s authorization                  => '+IO::K8s::PrometheusOperator::V1alpha1::SafeAuthorization';
k8s azureSDConfigs                 => ['+IO::K8s::PrometheusOperator::V1alpha1::AzureSDConfig'];
k8s basicAuth                      => '+IO::K8s::PrometheusOperator::V1alpha1::BasicAuth';
k8s bodySizeLimit                  => Str, { pattern => qr/(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$/ };
k8s consulSDConfigs                => ['+IO::K8s::PrometheusOperator::V1alpha1::ConsulSDConfig'];
k8s convertClassicHistogramsToNHCB => Bool;
k8s digitalOceanSDConfigs          => ['+IO::K8s::PrometheusOperator::V1alpha1::DigitalOceanSDConfig'];
k8s dnsSDConfigs                   => ['+IO::K8s::PrometheusOperator::V1alpha1::DNSSDConfig'];
k8s dockerSDConfigs                => ['+IO::K8s::PrometheusOperator::V1alpha1::DockerSDConfig'];
k8s dockerSwarmSDConfigs           => ['+IO::K8s::PrometheusOperator::V1alpha1::DockerSwarmSDConfig'];
k8s ec2SDConfigs                   => ['+IO::K8s::PrometheusOperator::V1alpha1::EC2SDConfig'];
k8s enableCompression              => Bool;
k8s enableHTTP2                    => Bool;
k8s eurekaSDConfigs                => ['+IO::K8s::PrometheusOperator::V1alpha1::EurekaSDConfig'];
k8s fallbackScrapeProtocol         => Str, { enum => [qw(PrometheusProto OpenMetricsText0.0.1 OpenMetricsText1.0.0 PrometheusText0.0.4 PrometheusText1.0.0)] };
k8s fileSDConfigs                  => ['+IO::K8s::PrometheusOperator::V1alpha1::FileSDConfig'];
k8s gceSDConfigs                   => ['+IO::K8s::PrometheusOperator::V1alpha1::GCESDConfig'];
k8s hetznerSDConfigs               => ['+IO::K8s::PrometheusOperator::V1alpha1::HetznerSDConfig'];
k8s honorLabels                    => Bool;
k8s honorTimestamps                => Bool;
k8s httpSDConfigs                  => ['+IO::K8s::PrometheusOperator::V1alpha1::HTTPSDConfig'];
k8s ionosSDConfigs                 => ['+IO::K8s::PrometheusOperator::V1alpha1::IonosSDConfig'];
k8s jobName                        => Str;
k8s keepDroppedTargets             => Int, { minimum => 0 };
k8s kubernetesSDConfigs            => ['+IO::K8s::PrometheusOperator::V1alpha1::KubernetesSDConfig'];
k8s kumaSDConfigs                  => ['+IO::K8s::PrometheusOperator::V1alpha1::KumaSDConfig'];
k8s labelLimit                     => Int, { minimum => 0 };
k8s labelNameLengthLimit           => Int, { minimum => 0 };
k8s labelValueLengthLimit          => Int, { minimum => 0 };
k8s lightSailSDConfigs             => ['+IO::K8s::PrometheusOperator::V1alpha1::LightSailSDConfig'];
k8s linodeSDConfigs                => ['+IO::K8s::PrometheusOperator::V1alpha1::LinodeSDConfig'];
k8s metricRelabelings              => ['+IO::K8s::PrometheusOperator::V1alpha1::RelabelConfig'];
k8s metricsPath                    => Str;
k8s nameEscapingScheme             => Str, { enum => [qw(AllowUTF8 Underscores Dots Values)] };
k8s nameValidationScheme           => Str, { enum => [qw(UTF8 Legacy)] };
k8s nativeHistogramBucketLimit     => Int, { minimum => 0 };
k8s nativeHistogramMinBucketFactor => IntOrStr, { pattern => qr/^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$/ };
k8s noProxy                        => Str;
k8s nomadSDConfigs                 => ['+IO::K8s::PrometheusOperator::V1alpha1::NomadSDConfig'];
k8s oauth2                         => '+IO::K8s::PrometheusOperator::V1alpha1::OAuth2';
k8s openstackSDConfigs             => ['+IO::K8s::PrometheusOperator::V1alpha1::OpenStackSDConfig'];
k8s ovhcloudSDConfigs              => ['+IO::K8s::PrometheusOperator::V1alpha1::OVHCloudSDConfig'];
k8s params                         => { Str => 1 };
k8s proxyConnectHeader             => { Str => 1 };
k8s proxyFromEnvironment           => Bool;
k8s proxyUrl                       => Str, { pattern => qr/^(http|https|socks5):\/\/.+$/ };
k8s puppetDBSDConfigs              => ['+IO::K8s::PrometheusOperator::V1alpha1::PuppetDBSDConfig'];
k8s relabelings                    => ['+IO::K8s::PrometheusOperator::V1alpha1::RelabelConfig'];
k8s sampleLimit                    => Int, { minimum => 0 };
k8s scalewaySDConfigs              => ['+IO::K8s::PrometheusOperator::V1alpha1::ScalewaySDConfig'];
k8s scheme                         => Str, { enum => [qw(http https HTTP HTTPS)] };
k8s scrapeClass                    => Str;
k8s scrapeClassicHistograms        => Bool;
k8s scrapeInterval                 => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s scrapeNativeHistograms         => Bool;
k8s scrapeProtocols                => [Str], { enum => [qw(PrometheusProto OpenMetricsText0.0.1 OpenMetricsText1.0.0 PrometheusText0.0.4 PrometheusText1.0.0)] };
k8s scrapeTimeout                  => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s staticConfigs                  => ['+IO::K8s::PrometheusOperator::V1alpha1::StaticConfig'];
k8s targetLimit                    => Int, { minimum => 0 };
k8s tlsConfig                      => '+IO::K8s::PrometheusOperator::V1alpha1::SafeTLSConfig';
k8s trackTimestampsStaleness       => Bool;

=attr authorization

authorization defines the header to use on every scrape request.

=cut

=attr azureSDConfigs

azureSDConfigs defines a list of Azure service discovery configurations.

=cut

=attr basicAuth

basicAuth defines information to use on every scrape request.

=cut

=attr bodySizeLimit

bodySizeLimit defines a per-scrape limit on the size of the uncompressed
response body that will be accepted by Prometheus. Targets responding with
a body larger than this many bytes will cause the scrape to fail.

It requires Prometheus >= v2.28.0.

=cut

=attr consulSDConfigs

consulSDConfigs defines a list of Consul service discovery configurations.

=cut

=attr convertClassicHistogramsToNHCB

convertClassicHistogramsToNHCB defines whether to convert all scraped classic histograms into a native histogram with custom buckets.
It requires Prometheus >= v3.0.0.

=cut

=attr digitalOceanSDConfigs

digitalOceanSDConfigs defines a list of DigitalOcean service discovery configurations.

=cut

=attr dnsSDConfigs

dnsSDConfigs defines a list of DNS service discovery configurations.

=cut

=attr dockerSDConfigs

dockerSDConfigs defines a list of Docker service discovery configurations.

=cut

=attr dockerSwarmSDConfigs

dockerSwarmSDConfigs defines a list of Dockerswarm service discovery configurations.

=cut

=attr ec2SDConfigs

ec2SDConfigs defines a list of EC2 service discovery configurations.

=cut

=attr enableCompression

enableCompression when false, Prometheus will request uncompressed response from the scraped target.

It requires Prometheus >= v2.49.0.

If unset, Prometheus uses true by default.

=cut

=attr enableHTTP2

enableHTTP2 defines whether to enable HTTP2.

=cut

=attr eurekaSDConfigs

eurekaSDConfigs defines a list of Eureka service discovery configurations.

=cut

=attr fallbackScrapeProtocol

fallbackScrapeProtocol defines the protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.

It requires Prometheus >= v3.0.0.

=cut

=attr fileSDConfigs

fileSDConfigs defines a list of file service discovery configurations.

=cut

=attr gceSDConfigs

gceSDConfigs defines a list of GCE service discovery configurations.

=cut

=attr hetznerSDConfigs

hetznerSDConfigs defines a list of Hetzner service discovery configurations.

=cut

=attr honorLabels

honorLabels defines when true the metric's labels when they collide
with the target's labels.

=cut

=attr honorTimestamps

honorTimestamps defines whether Prometheus preserves the timestamps
when exposed by the target.

=cut

=attr httpSDConfigs

httpSDConfigs defines a list of HTTP service discovery configurations.

=cut

=attr ionosSDConfigs

ionosSDConfigs defines a list of IONOS service discovery configurations.

=cut

=attr jobName

jobName defines the value of the `job` label assigned to the scraped metrics by default.

The `job_name` field in the rendered scrape configuration is always controlled by the
operator to prevent duplicate job names, which Prometheus does not allow. Instead the
`job` label is set by means of relabeling configs.

=cut

=attr keepDroppedTargets

keepDroppedTargets defines the per-scrape limit on the number of targets dropped by relabeling
that will be kept in memory. 0 means no limit.

It requires Prometheus >= v2.47.0.

=cut

=attr kubernetesSDConfigs

kubernetesSDConfigs defines a list of Kubernetes service discovery configurations.

=cut

=attr kumaSDConfigs

kumaSDConfigs defines a list of Kuma service discovery configurations.

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

=attr lightSailSDConfigs

lightSailSDConfigs defines a list of Lightsail service discovery configurations.

=cut

=attr linodeSDConfigs

linodeSDConfigs defines a list of Linode service discovery configurations.

=cut

=attr metricRelabelings

metricRelabelings defines the metricRelabelings to apply to samples before ingestion.

=cut

=attr metricsPath

metricsPath defines the HTTP path to scrape for metrics. If empty, Prometheus uses the default value (e.g. /metrics).

=cut

=attr nameEscapingScheme

nameEscapingScheme defines the metric name escaping mode to request through content negotiation.

It requires Prometheus >= v3.4.0.

=cut

=attr nameValidationScheme

nameValidationScheme defines the validation scheme for metric and label names.

It requires Prometheus >= v3.0.0.

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

=attr noProxy

noProxy defines a comma-separated string that can contain IPs, CIDR notation, domain names
that should be excluded from proxying. IP and domain names can
contain port numbers.

It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.

=cut

=attr nomadSDConfigs

nomadSDConfigs defines a list of Nomad service discovery configurations.

=cut

=attr oauth2

oauth2 defines the configuration to use on every scrape request.

=cut

=attr openstackSDConfigs

openstackSDConfigs defines a list of OpenStack service discovery configurations.

=cut

=attr ovhcloudSDConfigs

ovhcloudSDConfigs defines a list of OVHcloud service discovery configurations.

=cut

=attr params

params defines optional HTTP URL parameters

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

=attr puppetDBSDConfigs

puppetDBSDConfigs defines a list of PuppetDB service discovery configurations.

=cut

=attr relabelings

relabelings defines how to rewrite the target's labels before scraping.
Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields.
The original scrape job's name is available via the `__tmp_prometheus_job_name` label.
More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config

=cut

=attr sampleLimit

sampleLimit defines per-scrape limit on number of scraped samples that will be accepted.

=cut

=attr scalewaySDConfigs

scalewaySDConfigs defines a list of Scaleway instances and baremetal service discovery configurations.

=cut

=attr scheme

scheme defines the protocol scheme used for requests.

=cut

=attr scrapeClass

scrapeClass defines the scrape class to apply.

=cut

=attr scrapeClassicHistograms

scrapeClassicHistograms defines whether to scrape a classic histogram that is also exposed as a native histogram.
It requires Prometheus >= v2.45.0.

Notice: `scrapeClassicHistograms` corresponds to the `always_scrape_classic_histograms` field in the Prometheus configuration.

=cut

=attr scrapeInterval

scrapeInterval defines the interval between consecutive scrapes.

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

scrapeTimeout defines the number of seconds to wait until a scrape request times out.
The value cannot be greater than the scrape interval otherwise the operator will reject the resource.

=cut

=attr staticConfigs

staticConfigs defines a list of static targets with a common label set.

=cut

=attr targetLimit

targetLimit defines a limit on the number of scraped targets that will be accepted.

=cut

=attr tlsConfig

tlsConfig defines the TLS configuration to use on every scrape request

=cut

=attr trackTimestampsStaleness

trackTimestampsStaleness defines whether Prometheus tracks staleness of
the metrics that have an explicit timestamp present in scraped data.
Has no effect if `honorTimestamps` is false.
It requires Prometheus >= v2.48.0.

=cut

1;
