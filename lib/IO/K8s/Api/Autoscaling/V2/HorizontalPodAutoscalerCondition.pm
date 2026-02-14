package IO::K8s::Api::Autoscaling::V2::HorizontalPodAutoscalerCondition;
# ABSTRACT: HorizontalPodAutoscalerCondition describes the state of a HorizontalPodAutoscaler at a certain point.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s lastTransitionTime => Str;

=attr lastTransitionTime

lastTransitionTime is the last time the condition transitioned from one status to another

=cut

k8s message => Str;

=attr message

message is a human-readable explanation containing details about the transition

=cut

k8s reason => Str;

=attr reason

reason is the reason for the condition's last transition.

=cut

k8s status => Str, 'required';

=attr status

status is the status of the condition (True, False, Unknown)

=cut

k8s type => Str, 'required';

=attr type

type describes the current condition

=cut

1;
