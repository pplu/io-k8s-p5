package IO::K8s::PrometheusOperator::V1alpha1::ScrapeConfig;
# ABSTRACT: ScrapeConfig defines a namespaced Prometheus scrape_config to be aggregated across multiple namespaces into the Prometheus configuration.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'monitoring.coreos.com/v1alpha1',
    resource_plural => 'scrapeconfigs';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::PrometheusOperator::V1alpha1::ScrapeConfigSpec', { required => 'schema' };
k8s status => '+IO::K8s::PrometheusOperator::V1alpha1::ConfigResourceStatus';

=attr spec

spec defines the specification of ScrapeConfigSpec.

=cut

=attr status

status defines the status subresource. It is under active development and is updated only when the
"StatusForConfigurationResources" feature gate is enabled.

Most recent observed status of the ScrapeConfig. Read-only.
More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
