package IO::K8s::Api::Storage::V1::VolumeError;
# ABSTRACT: VolumeError captures an error encountered during a volume operation.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s errorCode => Int;

=attr errorCode

errorCode is a numeric gRPC code representing the error encountered during Attach or Detach operations.

This field requires the MutableCSINodeAllocatableCount feature gate being enabled to be set.

=cut

k8s message => Str;

=attr message

message represents the error encountered during Attach or Detach operation. This string may be logged, so it should not contain sensitive information.

=cut

k8s time => Time;

=attr time

time represents the time the error was encountered.

=cut

1;
