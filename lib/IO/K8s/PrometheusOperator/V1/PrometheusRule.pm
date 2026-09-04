package IO::K8s::PrometheusOperator::V1::PrometheusRule;
# ABSTRACT: The `PrometheusRule` custom resource definition (CRD) defines [alerting](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) and [recording](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) rules to be evaluated by `Prometheus` or `ThanosRuler` objects.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'monitoring.coreos.com/v1',
    resource_plural => 'prometheusrules';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::PrometheusOperator::V1::PrometheusRuleSpec', { required => 'schema' };
k8s status => '+IO::K8s::PrometheusOperator::V1::ConfigResourceStatus';

=attr spec

spec defines the specification of desired alerting rule definitions for Prometheus.

=cut

=attr status

status defines the status subresource. It is under active development and is updated only when the
"StatusForConfigurationResources" feature gate is enabled.

Most recent observed status of the PrometheusRule. Read-only.
More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
