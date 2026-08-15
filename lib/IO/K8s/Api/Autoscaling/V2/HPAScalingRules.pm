package IO::K8s::Api::Autoscaling::V2::HPAScalingRules;
# ABSTRACT: HPAScalingRules configures the scaling behavior for one direction. These Rules are applied after calculating DesiredReplicas from metrics for the HPA. They can limit the scaling velocity by specifying scaling policies. They can prevent flapping by specifying the stabilization window, so that the number of replicas is not set instantly, instead, the safest value from the stabilization window is chosen.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s policies => ['Autoscaling::V2::HPAScalingPolicy'];

=attr policies

policies is a list of potential scaling polices which can be used during scaling. At least one policy must be specified, otherwise the HPAScalingRules will be discarded as invalid

=cut

k8s selectPolicy => Str;

=attr selectPolicy

selectPolicy is used to specify which policy should be used. If not set, the default value Max is used.

=cut

k8s stabilizationWindowSeconds => Int;

=attr stabilizationWindowSeconds

stabilizationWindowSeconds is the number of seconds for which past recommendations should be considered while scaling up or scaling down. StabilizationWindowSeconds must be greater than or equal to zero and less than or equal to 3600 (one hour). If not set, use the default values: - For scale up: 0 (i.e. no stabilization is done). - For scale down: 300 (i.e. the stabilization window is 300 seconds long).

=cut

k8s tolerance => Quantity;

=attr tolerance

tolerance is the tolerance on the ratio between the current and desired metric value under which no additional scaling is performed. If not set, the default cluster-wide tolerance is applied (by default 10%).

For example, if autoscaling is triggered by consecutive (in a row) metric values, that violate the tolerance and this is configured to 0.1, this means that we will start scaling up/down only when the ratio of desired metric value to the current metric value is more than 1.1 or less than 0.9 respectively.

This is a beta field and requires enabling the HPAConfigurableTolerance feature gate.

=cut

1;
