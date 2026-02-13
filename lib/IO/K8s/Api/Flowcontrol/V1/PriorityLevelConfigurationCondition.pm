package IO::K8s::Api::Flowcontrol::V1::PriorityLevelConfigurationCondition;
# ABSTRACT: PriorityLevelConfigurationCondition defines the condition of priority level.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s lastTransitionTime => Str;

=attr lastTransitionTime

`lastTransitionTime` is the last time the condition transitioned from one status to another.

=cut

k8s message => Str;

=attr message

`message` is a human-readable message indicating details about last transition.

=cut

k8s reason => Str;

=attr reason

`reason` is a unique, one-word, CamelCase reason for the condition's last transition.

=cut

k8s status => Str;

=attr status

`status` is the status of the condition. Can be True, False, Unknown. Required.

=cut

k8s type => Str;

=attr type

`type` is the type of the condition. Required.

=cut

1;
