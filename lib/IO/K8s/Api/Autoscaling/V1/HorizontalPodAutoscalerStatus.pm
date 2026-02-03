package IO::K8s::Api::Autoscaling::V1::HorizontalPodAutoscalerStatus;
# ABSTRACT: current status of a horizontal pod autoscaler

use IO::K8s::Resource;

k8s currentCPUUtilizationPercentage => Int;

=attr currentCPUUtilizationPercentage

currentCPUUtilizationPercentage is the current average CPU utilization over all pods, represented as a percentage of requested CPU, e.g. 70 means that an average pod is using now 70% of its requested CPU.

=cut

k8s currentReplicas => Int, 'required';

=attr currentReplicas

currentReplicas is the current number of replicas of pods managed by this autoscaler.

=cut

k8s desiredReplicas => Int, 'required';

=attr desiredReplicas

desiredReplicas is the  desired number of replicas of pods managed by this autoscaler.

=cut

k8s lastScaleTime => Str;

=attr lastScaleTime

lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods; used by the autoscaler to control how often the number of pods is changed.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

observedGeneration is the most recent generation observed by this autoscaler.

=cut

1;
