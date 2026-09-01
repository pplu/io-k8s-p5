package IO::K8s::Api::Core::V1::VolumeHealthCondition;
# ABSTRACT: VolumeHealthCondition represents an adverse health condition reported for a volume.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s message => Str;

=attr message

message is a human-readable description. Maximum permitted length of a message is 1024 bytes.

=cut

k8s reason => Str, 'required';

=attr reason

reason is a brief CamelCase machine-parseable reason. Together with status it forms the unique identity of a condition entry. Maximum permitted length of a reason is 256 bytes.

=cut

k8s status => Str, 'required';

=attr status

status is the machine-parseable health category. Possible values: - "Inaccessible": the volume cannot be accessed. - "DataLoss": data loss has been detected on the volume. - "Degraded": the volume is functioning with reduced capability.

=cut

1;
