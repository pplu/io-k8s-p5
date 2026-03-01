package IO::K8s::Api::Resource::V1alpha3::AllocationResult;
# ABSTRACT: AllocationResult contains attributes of an allocated resource.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s controller => Str;

=attr controller

Controller is the name of the DRA driver which handled the allocation. That driver is also responsible for deallocating the claim. It is empty when the claim can be deallocated without involving a driver.

A driver may allocate devices provided by other drivers, so this driver name here can be different from the driver names listed for the results.

This is an alpha field and requires enabling the DRAControlPlaneController feature gate.

=cut

k8s devices => 'Resource::V1alpha3::DeviceAllocationResult';

=attr devices

Devices is the result of allocating devices.

=cut

k8s nodeSelector => 'Core::V1::NodeSelector';

=attr nodeSelector

NodeSelector defines where the allocated resources are available. If unset, they are available everywhere.

=cut

1;
