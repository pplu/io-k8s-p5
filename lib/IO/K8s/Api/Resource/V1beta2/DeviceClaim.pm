package IO::K8s::Api::Resource::V1beta2::DeviceClaim;
# ABSTRACT: DeviceClaim defines how to request devices with a ResourceClaim.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s config => ['Resource::V1beta2::DeviceClaimConfiguration'];

=attr config

This field holds configuration for multiple potential drivers which could satisfy requests in this claim. It is ignored while allocating the claim.

=cut

k8s constraints => ['Resource::V1beta2::DeviceConstraint'];

=attr constraints

These constraints must be satisfied by the set of devices that get allocated for the claim.

=cut

k8s requests => ['Resource::V1beta2::DeviceRequest'];

=attr requests

Requests represent individual requests for distinct devices which must all be satisfied. If empty, nothing needs to be allocated.

=cut

1;
