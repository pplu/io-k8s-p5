package IO::K8s::PrometheusOperator::V1::PodMonitor;
# ABSTRACT: The `PodMonitor` custom resource definition (CRD) defines how `Prometheus` and `PrometheusAgent` can scrape metrics from a group of pods.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'monitoring.coreos.com/v1',
    resource_plural => 'podmonitors';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::PrometheusOperator::V1::PodMonitorSpec', { required => 'schema' };
k8s status => '+IO::K8s::PrometheusOperator::V1::ConfigResourceStatus';

=attr spec

spec defines the specification of desired Pod selection for target discovery by Prometheus.

=cut

=attr status

status defines the status subresource. It is under active development and is updated only when the
"StatusForConfigurationResources" feature gate is enabled.

Most recent observed status of the PodMonitor. Read-only.
More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
