package IO::K8s::Api::Resource::V1::AllocationResult;
# ABSTRACT: AllocationResult contains attributes of an allocated resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allocationTimestamp => Time;

=attr allocationTimestamp

AllocationTimestamp stores the time when the resources were allocated. This field is not guaranteed to be set, in which case that time is unknown.

This is a beta field and requires enabling the DRADeviceBindingConditions and DRAResourceClaimDeviceStatus feature gate.

=cut

k8s devices => 'Resource::V1::DeviceAllocationResult';

=attr devices

Devices is the result of allocating devices.

=cut

k8s nodeSelector => 'Core::V1::NodeSelector';

=attr nodeSelector

NodeSelector defines where the allocated resources are available. If unset, they are available everywhere.

=cut

1;
