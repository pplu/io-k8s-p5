package IO::K8s::Api::Core::V1::PodCondition;
# ABSTRACT: PodCondition contains details for the current condition of this pod.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s lastProbeTime => Time;

=attr lastProbeTime

Last time we probed the condition.

=cut

k8s lastTransitionTime => Time;

=attr lastTransitionTime

Last time the condition transitioned from one status to another.

=cut

k8s message => Str;

=attr message

Human-readable message indicating details about last transition.

=cut

k8s reason => Str;

=attr reason

Unique, one-word, CamelCase reason for the condition's last transition.

=cut

k8s status => Str, 'required';

=attr status

Status is the status of the condition. Can be True, False, Unknown. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-conditions

=cut

k8s type => Str, 'required';

=attr type

Type is the type of the condition. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-conditions

=cut

1;
