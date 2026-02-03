package IO::K8s::Api::Autoscaling::V2::ExternalMetricSource;
# ABSTRACT: ExternalMetricSource indicates how to scale on a metric not associated with any Kubernetes object (for example length of queue in cloud messaging service, or QPS from loadbalancer running outside of cluster).

use IO::K8s::Resource;

k8s metric => 'Autoscaling::V2::MetricIdentifier', 'required';

=attr metric

metric identifies the target metric by name and selector

=cut

k8s target => 'Autoscaling::V2::MetricTarget', 'required';

=attr target

target specifies the target value for the given metric

=cut

1;
