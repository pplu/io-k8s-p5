package IO::K8s::PrometheusOperator::V1::ServiceMonitorSpec;
# ABSTRACT: spec defines the specification of desired Service selection for target discovery by Prometheus.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s attachMetadata                 => '+IO::K8s::PrometheusOperator::V1::AttachMetadata';
k8s bodySizeLimit                  => Str, { pattern => qr/(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$/ };
k8s convertClassicHistogramsToNHCB => Bool;
k8s endpoints                      => ['+IO::K8s::PrometheusOperator::V1::Endpoint'], { required => 'schema' };
k8s fallbackScrapeProtocol         => Str, { enum => [qw(PrometheusProto OpenMetricsText0.0.1 OpenMetricsText1.0.0 PrometheusText0.0.4 PrometheusText1.0.0)] };
k8s jobLabel                       => Str;
k8s keepDroppedTargets             => Int, { minimum => 0 };
k8s labelLimit                     => Int, { minimum => 0 };
k8s labelNameLengthLimit           => Int, { minimum => 0 };
k8s labelValueLengthLimit          => Int, { minimum => 0 };
k8s namespaceSelector              => '+IO::K8s::PrometheusOperator::V1::NamespaceSelector';
k8s nativeHistogramBucketLimit     => Int, { minimum => 0 };
k8s nativeHistogramMinBucketFactor => IntOrStr, { pattern => qr/^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$/ };
k8s podTargetLabels                => [Str];
k8s sampleLimit                    => Int, { minimum => 0 };
k8s scrapeClass                    => Str;
k8s scrapeClassicHistograms        => Bool;
k8s scrapeNativeHistograms         => Bool;
k8s scrapeProtocols                => [Str], { enum => [qw(PrometheusProto OpenMetricsText0.0.1 OpenMetricsText1.0.0 PrometheusText0.0.4 PrometheusText1.0.0)] };
k8s selector                       => 'Meta::V1::LabelSelector', { required => 'schema' };
k8s selectorMechanism              => Str, { enum => [qw(RelabelConfig RoleSelector)] };
k8s serviceDiscoveryRole           => Str, { enum => [qw(Endpoints EndpointSlice)] };
k8s targetLabels                   => [Str];
k8s targetLimit                    => Int, { minimum => 0 };

=attr attachMetadata

attachMetadata defines additional metadata which is added to the
discovered targets.

It requires Prometheus >= v2.37.0.

=cut

=attr bodySizeLimit

bodySizeLimit when defined, bodySizeLimit specifies a job level limit on the size
of uncompressed response body that will be accepted by Prometheus.

It requires Prometheus >= v2.28.0.

=cut

=attr convertClassicHistogramsToNHCB

convertClassicHistogramsToNHCB defines whether to convert all scraped classic histograms into a native histogram with custom buckets.
It requires Prometheus >= v3.0.0.

=cut

=attr endpoints

endpoints defines the list of endpoints part of this ServiceMonitor.
Defines how to scrape metrics from Kubernetes [Endpoints](https://kubernetes.io/docs/concepts/services-networking/service/#endpoints) objects.
In most cases, an Endpoints object is backed by a Kubernetes [Service](https://kubernetes.io/docs/concepts/services-networking/service/) object with the same name and labels.

=cut

=attr fallbackScrapeProtocol

fallbackScrapeProtocol defines the protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.

It requires Prometheus >= v3.0.0.

=cut

=attr jobLabel

jobLabel selects the label from the associated Kubernetes `Service`
object which will be used as the `job` label for all metrics.

For example if `jobLabel` is set to `foo` and the Kubernetes `Service`
object is labeled with `foo: bar`, then Prometheus adds the `job="bar"`
label to all ingested metrics.

If the value of this field is empty or if the label doesn't exist for
the given Service, the `job` label of the metrics defaults to the name
of the associated Kubernetes `Service`.

=cut

=attr keepDroppedTargets

keepDroppedTargets defines the per-scrape limit on the number of targets dropped by relabeling
that will be kept in memory. 0 means no limit.

It requires Prometheus >= v2.47.0.

=cut

=attr labelLimit

labelLimit defines the per-scrape limit on number of labels that will be accepted for a sample.

It requires Prometheus >= v2.27.0.

=cut

=attr labelNameLengthLimit

labelNameLengthLimit defines the per-scrape limit on length of labels name that will be accepted for a sample.

It requires Prometheus >= v2.27.0.

=cut

=attr labelValueLengthLimit

labelValueLengthLimit defines the per-scrape limit on length of labels value that will be accepted for a sample.

It requires Prometheus >= v2.27.0.

=cut

=attr namespaceSelector

namespaceSelector defines in which namespace(s) Prometheus should discover the services.
By default, the services are discovered in the same namespace as the `ServiceMonitor` object but it is possible to select pods across different/all namespaces.

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

=attr podTargetLabels

podTargetLabels defines the labels which are transferred from the
associated Kubernetes `Pod` object onto the ingested metrics.

=cut

=attr sampleLimit

sampleLimit defines a per-scrape limit on the number of scraped samples
that will be accepted.

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

=attr selector

selector defines the label selector to select the Kubernetes `Endpoints` objects to scrape metrics from.

=cut

=attr selectorMechanism

selectorMechanism defines the mechanism used to select the endpoints to scrape.
By default, the selection process relies on relabel configurations to filter the discovered targets.
Alternatively, you can opt in for role selectors, which may offer better efficiency in large clusters.
Which strategy is best for your use case needs to be carefully evaluated.

It requires Prometheus >= v2.17.0.

=cut

=attr serviceDiscoveryRole

serviceDiscoveryRole defines the service discovery role used to discover targets.

If set, the value should be either "Endpoints" or "EndpointSlice".
Otherwise it defaults to the value defined in the
Prometheus/PrometheusAgent resource.

=cut

=attr targetLabels

targetLabels defines the labels which are transferred from the
associated Kubernetes `Service` object onto the ingested metrics.

=cut

=attr targetLimit

targetLimit defines a limit on the number of scraped targets that will
be accepted.

=cut

1;
