package IO::K8s::Api::Core::V1::NodeCondition;
# ABSTRACT: NodeCondition contains condition information for a node.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s lastHeartbeatTime => Str;

=attr lastHeartbeatTime

Last time we got an update on a given condition.

=cut

k8s lastTransitionTime => Str;

=attr lastTransitionTime

Last time the condition transit from one status to another.

=cut

k8s message => Str;

=attr message

Human readable message indicating details about last transition.

=cut

k8s reason => Str;

=attr reason

(brief) reason for the condition's last transition.

=cut

k8s status => Str, 'required';

=attr status

Status of the condition, one of True, False, Unknown.

=cut

k8s type => Str, 'required';

=attr type

Type of node condition.

=cut

1;
