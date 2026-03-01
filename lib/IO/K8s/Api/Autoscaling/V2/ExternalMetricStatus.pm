package IO::K8s::Api::Autoscaling::V2::ExternalMetricStatus;
# ABSTRACT: ExternalMetricStatus indicates the current value of a global metric not associated with any Kubernetes object.
our $VERSION = '1.007';
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
