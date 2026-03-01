package IO::K8s::Api::Resource::V1alpha3::ResourceClaimSpec;
# ABSTRACT: ResourceClaimSpec defines what is being requested in a ResourceClaim and how to configure it.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s controller => Str;

=attr controller

Controller is the name of the DRA driver that is meant to handle allocation of this claim. If empty, allocation is handled by the scheduler while scheduling a pod.

Must be a DNS subdomain and should end with a DNS domain owned by the vendor of the driver.

This is an alpha field and requires enabling the DRAControlPlaneController feature gate.

=cut

k8s devices => 'Resource::V1alpha3::DeviceClaim';

=attr devices

Devices defines how to request devices.

=cut

1;
