package IO::K8s::Api::Resource::V1::CapacityRequestPolicy;
# ABSTRACT: CapacityRequestPolicy defines how requests consume device capacity. Must not set more than one ValidRequestValues.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s default => Quantity;

=attr default

Default specifies how much of this capacity is consumed by a request that does not contain an entry for it in DeviceRequest's Capacity.

=cut

k8s validRange => 'Resource::V1::CapacityRequestPolicyRange';

=attr validRange

ValidRange defines an acceptable quantity value range in consuming requests. If this field is set, Default must be defined and it must fall within the defined ValidRange. If the requested amount does not fall within the defined range, the request violates the policy, and this device cannot be allocated. If the request doesn't contain this capacity entry, Default value is used.

=cut

k8s validValues => [Quantity];

=attr validValues

ValidValues defines a set of acceptable quantity values in consuming requests. Must not contain more than 10 entries. Must be sorted in ascending order. If this field is set, Default must be defined and it must be included in ValidValues list. If the requested amount does not match any valid value but smaller than some valid values, the scheduler calculates the smallest valid value that is greater than or equal to the request. If the requested amount exceeds all valid values, the request violates the policy, and this device cannot be allocated.

=cut

1;
