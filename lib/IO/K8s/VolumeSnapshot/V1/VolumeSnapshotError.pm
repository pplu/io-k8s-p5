package IO::K8s::VolumeSnapshot::V1::VolumeSnapshotError;
# ABSTRACT: VolumeSnapshotError describes an error encountered during snapshot creation
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s message => Str;
k8s time    => Time;

=attr message

message is a string detailing the encountered error during snapshot creation if specified. NOTE: message may be logged, and it should not contain sensitive information.

=cut

=attr time

time is the timestamp when the error was encountered.

=cut

1;
