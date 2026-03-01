package IO::K8s::Api::Autoscaling::V2::MetricValueStatus;
# ABSTRACT: MetricValueStatus holds the current value for a metric
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s averageUtilization => Int;

=attr averageUtilization

currentAverageUtilization is the current value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods.

=cut

k8s averageValue => Quantity;

=attr averageValue

averageValue is the current value of the average of the metric across all relevant pods (as a quantity)

=cut

k8s value => Quantity;

=attr value

value is the current value of the metric (as a quantity).

=cut

1;
