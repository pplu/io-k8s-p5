package IO::K8s::PrometheusOperator::V1::ProbeTargets;
# ABSTRACT: targets defines a set of static or dynamically discovered targets to probe.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ingress      => '+IO::K8s::PrometheusOperator::V1::ProbeTargetIngress';
k8s staticConfig => '+IO::K8s::PrometheusOperator::V1::ProbeTargetStaticConfig';

=attr ingress

ingress defines the Ingress objects to probe and the relabeling
configuration.
If `staticConfig` is also defined, `staticConfig` takes precedence.

=cut

=attr staticConfig

staticConfig defines the static list of targets to probe and the
relabeling configuration.
If `ingress` is also defined, `staticConfig` takes precedence.
More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#static_config.

=cut

1;
