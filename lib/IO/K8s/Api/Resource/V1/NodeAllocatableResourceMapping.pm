package IO::K8s::Api::Resource::V1::NodeAllocatableResourceMapping;
# ABSTRACT: NodeAllocatableResourceMapping defines the translation between the DRA device/capacity units requested to the corresponding quantity of the node allocatable resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allocationMultiplier => Quantity;

=attr allocationMultiplier

AllocationMultiplier is used as a multiplier for the allocated device count or the allocated capacity in the claim. It defaults to 1 if not specified.

How the field is used also depends on whether C<capacityKey> is set.

If C<capacityKey> is NOT set, C<allocationMultiplier> multiplies the device count allocated to the claim. For example, a DRA driver representing each CPU core as a device would have C<{ResourceName: "cpu", allocationMultiplier: "2"}> in its C<nodeAllocatableResourceMappings>. If 4 devices are allocated to the claim, 4 * 2 CPUs would be considered as allocated and subtracted from the node's capacity.

If C<capacityKey> IS set, C<allocationMultiplier> is multiplied by the amount of that capacity consumed. The final node allocatable resource amount is C<consumedCapacity[capacityKey]> * C<allocationMultiplier>.

=cut

k8s capacityKey => Str;

=attr capacityKey

CapacityKey references a capacity name defined as a key in the C<spec.devices[*].capacity> map. When this field is set, the value associated with this key in the C<status.allocation.devices.results[*].consumedCapacity> map (for a specific claim allocation) determines the base quantity for the node allocatable resource. If C<allocationMultiplier> is also set, it is multiplied with the base quantity.

=cut

1;
