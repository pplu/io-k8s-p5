package IO::K8s::PrometheusOperator::V1alpha1::ConfigResourceStatus;
# ABSTRACT: status defines the status subresource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s bindings => ['+IO::K8s::PrometheusOperator::V1alpha1::WorkloadBinding'];

=attr bindings

bindings defines the list of workload resources (Prometheus, PrometheusAgent, ThanosRuler or Alertmanager) which select the configuration resource.

=cut

1;
