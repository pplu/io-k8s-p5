package IO::K8s::Api::Autoscaling::V2::ObjectMetricStatus;
# ABSTRACT: ObjectMetricStatus indicates the current value of a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s current => 'Autoscaling::V2::MetricValueStatus', 'required';

=attr current

current contains the current value for the given metric

=cut

k8s describedObject => 'Autoscaling::V2::CrossVersionObjectReference', 'required';

=attr describedObject

DescribedObject specifies the descriptions of a object,such as kind,name apiVersion

=cut

k8s metric => 'Autoscaling::V2::MetricIdentifier', 'required';

=attr metric

metric identifies the target metric by name and selector

=cut

1;
