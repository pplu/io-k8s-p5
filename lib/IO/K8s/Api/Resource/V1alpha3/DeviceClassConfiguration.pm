package IO::K8s::Api::Resource::V1alpha3::DeviceClassConfiguration;
# ABSTRACT: DeviceClassConfiguration is used in DeviceClass.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s opaque => 'Resource::V1alpha3::OpaqueDeviceConfiguration';

=attr opaque

Opaque provides driver-specific configuration parameters.

=cut

1;
