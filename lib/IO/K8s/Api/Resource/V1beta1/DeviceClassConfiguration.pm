package IO::K8s::Api::Resource::V1beta1::DeviceClassConfiguration;
# ABSTRACT: DeviceClassConfiguration is used in DeviceClass.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s opaque => 'Resource::V1beta1::OpaqueDeviceConfiguration';

=attr opaque

Opaque provides driver-specific configuration parameters.

=cut

1;
