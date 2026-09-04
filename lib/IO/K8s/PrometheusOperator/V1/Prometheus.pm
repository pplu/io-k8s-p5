package IO::K8s::PrometheusOperator::V1::Prometheus;
# ABSTRACT: The `Prometheus` custom resource definition (CRD) defines a desired [Prometheus](https://prometheus.io/docs/prometheus) setup to run in a Kubernetes cluster.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'monitoring.coreos.com/v1',
    resource_plural => 'prometheuses';
with 'IO::K8s::Role::Namespaced';

k8s spec   => '+IO::K8s::PrometheusOperator::V1::PrometheusSpec', { required => 'schema' };
k8s status => '+IO::K8s::PrometheusOperator::V1::PrometheusStatus';

=attr spec

spec defines the specification of the desired behavior of the Prometheus cluster. More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

=attr status

status defines the most recent observed status of the Prometheus cluster. Read-only.
More info:
https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

=cut

1;
