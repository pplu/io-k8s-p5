package IO::K8s::Api::Flowcontrol::V1beta3::PriorityLevelConfigurationCondition;
# ABSTRACT: PriorityLevelConfigurationCondition defines the condition of priority level.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;

=attr lastTransitionTime

C<lastTransitionTime> is the last time the condition transitioned from one status to another.

=cut

k8s message => Str;

=attr message

C<message> is a human-readable message indicating details about last transition.

=cut

k8s reason => Str;

=attr reason

C<reason> is a unique, one-word, CamelCase reason for the condition's last transition.

=cut

k8s status => Str;

=attr status

C<status> is the status of the condition. Can be True, False, Unknown. Required.

=cut

k8s type => Str;

=attr type

`type` is the type of the condition. Required.

=cut

1;
