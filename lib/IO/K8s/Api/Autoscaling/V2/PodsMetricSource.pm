package IO::K8s::Api::Autoscaling::V2::PodsMetricSource;
# ABSTRACT: PodsMetricSource indicates how to scale on a metric describing each pod in the current scale target (for example, transactions-processed-per-second). The values will be averaged together before being compared to the target value.
our $VERSION = '1.004';
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
