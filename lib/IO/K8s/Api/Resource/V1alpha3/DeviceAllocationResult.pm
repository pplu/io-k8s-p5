package IO::K8s::Api::Resource::V1alpha3::DeviceAllocationResult;
# ABSTRACT: DeviceAllocationResult is the result of allocating devices.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s config => ['Resource::V1alpha3::DeviceAllocationConfiguration'];

=attr config

This field is a combination of all the claim and class configuration parameters. Drivers can distinguish between those based on a flag.

This includes configuration parameters for drivers which have no allocated devices in the result because it is up to the drivers which configuration parameters they support. They can silently ignore unknown configuration parameters.

=cut

k8s results => ['Resource::V1alpha3::DeviceRequestAllocationResult'];

=attr results

Results lists all allocated devices.

=cut

1;
