package IO::K8s::Api::Storage::V1::StorageHealthCondition;
# ABSTRACT: StorageHealthCondition represents an adverse health condition reported by a CSI driver for its storage backend on a node.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessMode => Str;

=attr accessMode

accessMode is the access mode affected. Nil means all access modes are affected.

=cut

k8s lastTransitionTime => Time;

=attr lastTransitionTime

lastTransitionTime is when this condition first appeared at its current state.

=cut

k8s message => Str;

=attr message

message is a human-readable description. Maximum permitted length of a message is 1024 characters.

=cut

k8s reason => Str, 'required';

=attr reason

reason is a brief CamelCase machine-parseable reason. Maximum permitted length of a reason is 256 characters.

=cut

k8s status => Str, 'required';

=attr status

status is the health status category. One of "StorageUnreachable", "StorageDegraded".

=cut

k8s volumeMode => Str;

=attr volumeMode

volumeMode is the volume mode affected. Nil means both are affected.

=cut

1;
