package IO::K8s::PrometheusOperator::V1::ProbeTargetStaticConfig;
# ABSTRACT: staticConfig defines the static list of targets to probe and the relabeling configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s labels            => { Str => 1 };
k8s relabelingConfigs => ['+IO::K8s::PrometheusOperator::V1::RelabelConfig'];
k8s static            => [Str];

=attr labels

labels defines all labels assigned to all metrics scraped from the targets.

=cut

=attr relabelingConfigs

relabelingConfigs defines relabelings to be apply to the label set of the targets before it gets
scraped.
More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config

=cut

=attr static

static defines the list of hosts to probe.

=cut

1;
