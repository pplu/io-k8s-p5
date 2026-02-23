package IO::K8s::Api::Core::V1::PersistentVolumeClaimCondition;
# ABSTRACT: PersistentVolumeClaimCondition contains details about state of pvc
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s lastProbeTime => Str;

=attr lastProbeTime

lastProbeTime is the time we probed the condition.

=cut

k8s lastTransitionTime => Str;

=attr lastTransitionTime

lastTransitionTime is the time the condition transitioned from one status to another.

=cut

k8s message => Str;

=attr message

message is the human-readable message indicating details about last transition.

=cut

k8s reason => Str;

=attr reason

reason is a unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports "Resizing" that means the underlying persistent volume is being resized.

=cut

k8s status => Str, 'required';

k8s type => Str, 'required';

1;
