package IO::K8s::PrometheusOperator::V1::ProbeTargetIngress;
# ABSTRACT: ingress defines the Ingress objects to probe and the relabeling configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s namespaceSelector => '+IO::K8s::PrometheusOperator::V1::NamespaceSelector';
k8s relabelingConfigs => ['+IO::K8s::PrometheusOperator::V1::RelabelConfig'];
k8s selector          => 'Meta::V1::LabelSelector';

=attr namespaceSelector

namespaceSelector defines from which namespaces to select Ingress objects.

=cut

=attr relabelingConfigs

relabelingConfigs to apply to the label set of the target before it gets
scraped.
The original ingress address is available via the
`__tmp_prometheus_ingress_address` label. It can be used to customize the
probed URL.
The original scrape job's name is available via the `__tmp_prometheus_job_name` label.
More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config

=cut

=attr selector

selector to select the Ingress objects.

=cut

1;
