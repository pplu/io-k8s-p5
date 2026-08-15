package IO::K8s::Api::Resource::V1beta2::DeviceClassConfiguration;
# ABSTRACT: DeviceClassConfiguration is used in DeviceClass.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s opaque => 'Resource::V1beta2::OpaqueDeviceConfiguration';

=attr opaque

Opaque provides driver-specific configuration parameters.

=cut

1;
