package IO::K8s::Api::Autoscaling::V2::HorizontalPodAutoscalerStatus;
# ABSTRACT: HorizontalPodAutoscalerStatus describes the current status of a horizontal pod autoscaler.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s conditions => ['Autoscaling::V2::HorizontalPodAutoscalerCondition'];

=attr conditions

conditions is the set of conditions required for this autoscaler to scale its target, and indicates whether or not those conditions are met.

=cut

k8s currentMetrics => ['Autoscaling::V2::MetricStatus'];

=attr currentMetrics

currentMetrics is the last read state of the metrics used by this autoscaler.

=cut

k8s currentReplicas => Int;

=attr currentReplicas

currentReplicas is current number of replicas of pods managed by this autoscaler, as last seen by the autoscaler.

=cut

k8s desiredReplicas => Int, 'required';

=attr desiredReplicas

desiredReplicas is the desired number of replicas of pods managed by this autoscaler, as last calculated by the autoscaler.

=cut

k8s lastScaleTime => Time;

=attr lastScaleTime

lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods, used by the autoscaler to control how often the number of pods is changed.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

observedGeneration is the most recent generation observed by this autoscaler.

=cut

1;
