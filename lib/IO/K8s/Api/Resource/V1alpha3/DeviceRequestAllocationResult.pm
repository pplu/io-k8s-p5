package IO::K8s::Api::Resource::V1alpha3::DeviceRequestAllocationResult;
# ABSTRACT: DeviceRequestAllocationResult contains the allocation result for one request.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s device => Str, 'required';

=attr device

Device references one device instance via its name in the driver's resource pool. It must be a DNS label.

=cut

k8s driver => Str, 'required';

=attr driver

Driver specifies the name of the DRA driver whose kubelet plugin should be invoked to process the allocation once the claim is needed on a node.

Must be a DNS subdomain and should end with a DNS domain owned by the vendor of the driver.

=cut

k8s pool => Str, 'required';

=attr pool

This name together with the driver name and the device name field identify which device was allocated (C<E<lt>driver nameE<gt>/E<lt>pool nameE<gt>/E<lt>device nameE<gt>>).

Must not be longer than 253 characters and may contain one or more DNS sub-domains separated by slashes.

=cut

k8s request => Str, 'required';

=attr request

Request is the name of the request in the claim which caused this device to be allocated. Multiple devices may have been allocated per request.

=cut

1;
