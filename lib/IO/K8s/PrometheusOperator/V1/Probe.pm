package IO::K8s::PrometheusOperator::V1::Probe;
# ABSTRACT: The `Probe` custom resource definition (CRD) defines how to scrape metrics from prober exporters such as the [blackbox exporter](https://github.com/prometheus/blackbox_exporter).
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'monitoring.coreos.com/v1',
    resource_plural => 'probes';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::PrometheusOperator::V1::ProbeSpec', { required => 'schema' };
k8s status => '+IO::K8s::PrometheusOperator::V1::ConfigResourceStatus';

=attr spec

spec defines the specification of desired Ingress selection for target discovery by Prometheus.

=cut

=attr status

status defines the status subresource. It is under active development and is updated only when the
"StatusForConfigurationResources" feature gate is enabled.

Most recent observed status of the Probe. Read-only.
More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
