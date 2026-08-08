package IO::K8s::Api::Resource::V1::ResourceClaimSpec;
# ABSTRACT: ResourceClaimSpec defines what is being requested in a ResourceClaim and how to configure it.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s devices => 'Resource::V1::DeviceClaim';

=attr devices

Devices defines how to request devices.

=cut

1;
