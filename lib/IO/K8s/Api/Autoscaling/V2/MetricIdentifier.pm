package IO::K8s::Api::Autoscaling::V2::MetricIdentifier;
# ABSTRACT: MetricIdentifier defines the name and optionally selector for a metric
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

name is the name of the given metric

=cut

k8s selector => 'Meta::V1::LabelSelector';

=attr selector

selector is the string-encoded form of a standard kubernetes label selector for the given metric When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping. When unset, just the metricName will be used to gather metrics.

=cut

1;
