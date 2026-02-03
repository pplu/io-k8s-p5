package IO::K8s::Api::Resource::V1alpha3::DeviceClaimConfiguration;
# ABSTRACT: DeviceClaimConfiguration is used for configuration parameters in DeviceClaim.

use IO::K8s::Resource;

k8s opaque => 'Resource::V1alpha3::OpaqueDeviceConfiguration';

=attr opaque

Opaque provides driver-specific configuration parameters.

=cut

k8s requests => [Str];

=attr requests

Requests lists the names of requests where the configuration applies. If empty, it applies to all requests.

=cut

1;
