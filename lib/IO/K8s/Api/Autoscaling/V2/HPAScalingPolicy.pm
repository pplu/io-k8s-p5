package IO::K8s::Api::Autoscaling::V2::HPAScalingPolicy;
# ABSTRACT: HPAScalingPolicy is a single policy which must hold true for a specified past interval.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s periodSeconds => Int, 'required';

=attr periodSeconds

periodSeconds specifies the window of time for which the policy should hold true. PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).

=cut

k8s type => Str, 'required';

=attr type

type is used to specify the scaling policy.

=cut

k8s value => Int, 'required';

=attr value

value contains the amount of change which is permitted by the policy. It must be greater than zero

=cut

1;
