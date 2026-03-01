package IO::K8s::Api::Autoscaling::V2::ObjectMetricSource;
# ABSTRACT: ObjectMetricSource indicates how to scale on a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s describedObject => 'Autoscaling::V2::CrossVersionObjectReference', 'required';

=attr describedObject

describedObject specifies the descriptions of a object,such as kind,name apiVersion

=cut

k8s metric => 'Autoscaling::V2::MetricIdentifier', 'required';

=attr metric

metric identifies the target metric by name and selector

=cut

k8s target => 'Autoscaling::V2::MetricTarget', 'required';

=attr target

target specifies the target value for the given metric

=cut

1;
