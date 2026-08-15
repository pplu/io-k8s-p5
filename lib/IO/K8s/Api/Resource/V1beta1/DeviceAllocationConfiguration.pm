package IO::K8s::Api::Resource::V1beta1::DeviceAllocationConfiguration;
# ABSTRACT: DeviceAllocationConfiguration gets embedded in an AllocationResult.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s opaque => 'Resource::V1beta1::OpaqueDeviceConfiguration';

=attr opaque

Opaque provides driver-specific configuration parameters.

=cut

k8s requests => [Str];

=attr requests

Requests lists the names of requests where the configuration applies. If empty, its applies to all requests.  References to subrequests must include the name of the main request and may include the subrequest using the format <main request>[/<subrequest>]. If just the main request is given, the configuration applies to all subrequests.

=cut

k8s source => Str, 'required';

=attr source

Source records whether the configuration comes from a class and thus is not something that a normal user would have been able to set or from a claim.

=cut

1;
