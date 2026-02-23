package IO::K8s::Api::Autoscaling::V2::PodsMetricStatus;
# ABSTRACT: PodsMetricStatus indicates the current value of a metric describing each pod in the current scale target (for example, transactions-processed-per-second).
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s current => 'Autoscaling::V2::MetricValueStatus', 'required';

=attr current

current contains the current value for the given metric

=cut

k8s metric => 'Autoscaling::V2::MetricIdentifier', 'required';

=attr metric

metric identifies the target metric by name and selector

=cut

1;
