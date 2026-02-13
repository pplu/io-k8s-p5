package IO::K8s::Api::Autoscaling::V2::MetricTarget;
# ABSTRACT: MetricTarget defines the target value, average value, or average utilization of a specific metric
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s averageUtilization => Int;

=attr averageUtilization

averageUtilization is the target value of the average of the resource metric across all relevant pods, represented as a percentage of the requested value of the resource for the pods. Currently only valid for Resource metric source type

=cut

k8s averageValue => Str;

=attr averageValue

averageValue is the target value of the average of the metric across all relevant pods (as a quantity)

=cut

k8s type => Str, 'required';

=attr type

type represents whether the metric type is Utilization, Value, or AverageValue

=cut

k8s value => Str;

=attr value

value is the target value of the metric (as a quantity).

=cut

1;
