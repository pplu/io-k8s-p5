package IO::K8s::Api::Resource::V1alpha3::PoolStatus;
# ABSTRACT: PoolStatus contains status information for a single resource pool.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s allocatedDevices => Int;

=attr allocatedDevices

AllocatedDevices is the number of devices currently allocated to claims. A value of 0 means no devices are allocated. May be unset when validationError is set.

=cut

k8s availableDevices => Int;

=attr availableDevices

AvailableDevices is the number of devices available for allocation. This equals TotalDevices - AllocatedDevices - UnavailableDevices. A value of 0 means no devices are currently available. May be unset when validationError is set.

=cut

k8s driver => Str, 'required';

=attr driver

Driver is the DRA driver name for this pool. Must be a DNS subdomain (e.g., "gpu.example.com").

=cut

k8s generation => Int, 'required';

=attr generation

Generation is the pool generation observed across all ResourceSlices in this pool. Only the latest generation is reported. During a generation rollout, if not all slices at the latest generation have been published, the pool is included with a validationError and device counts unset.

=cut

k8s nodeName => Str;

=attr nodeName

NodeName is the node this pool is associated with. When omitted, the pool is not associated with a specific node. Must be a valid DNS subdomain name (RFC1123).

=cut

k8s poolName => Str, 'required';

=attr poolName

PoolName is the name of the pool. Must be a valid resource pool name (DNS subdomains separated by "/").

=cut

k8s resourceSliceCount => Int;

=attr resourceSliceCount

ResourceSliceCount is the number of ResourceSlices that make up this pool. May be unset when validationError is set.

=cut

k8s totalDevices => Int;

=attr totalDevices

TotalDevices is the total number of devices in the pool across all slices. A value of 0 means the pool has no devices. May be unset when validationError is set.

=cut

k8s unavailableDevices => Int;

=attr unavailableDevices

UnavailableDevices is the number of devices that are not available due to taints or other conditions, but are not allocated. A value of 0 means all unallocated devices are available. May be unset when validationError is set.

=cut

k8s validationError => Str;

=attr validationError

ValidationError is set when the pool's data could not be fully validated (e.g., incomplete slice publication). When set, device count fields and ResourceSliceCount may be unset.

=cut

1;
