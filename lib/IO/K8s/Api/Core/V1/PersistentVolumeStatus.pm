package IO::K8s::Api::Core::V1::PersistentVolumeStatus;
# ABSTRACT: PersistentVolumeStatus is the current status of a persistent volume.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s lastPhaseTransitionTime => Str;

=attr lastPhaseTransitionTime

lastPhaseTransitionTime is the time the phase transitioned from one to another and automatically resets to current time everytime a volume phase transitions.

=cut

k8s message => Str;

=attr message

message is a human-readable message indicating details about why the volume is in this state.

=cut

k8s phase => Str;

=attr phase

phase indicates if a volume is available, bound to a claim, or released by a claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#phase

=cut

k8s reason => Str;

=attr reason

reason is a brief CamelCase string that describes any failure and is meant for machine parsing and tidy display in the CLI.

=cut

1;
