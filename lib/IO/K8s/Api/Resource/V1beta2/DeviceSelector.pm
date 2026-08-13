package IO::K8s::Api::Resource::V1beta2::DeviceSelector;
# ABSTRACT: DeviceSelector must have exactly one field set.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s cel => 'Resource::V1beta2::CELDeviceSelector';

=attr cel

CEL contains a CEL expression for selecting a device.

=cut

1;
