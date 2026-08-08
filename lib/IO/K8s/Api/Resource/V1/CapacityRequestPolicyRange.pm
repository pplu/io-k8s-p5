package IO::K8s::Api::Resource::V1::CapacityRequestPolicyRange;
# ABSTRACT: CapacityRequestPolicyRange defines a valid range for consumable capacity values.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s max => Quantity;

=attr max

Max defines the upper limit for capacity that can be requested. Max must be less than or equal to the capacity value. Min and requestPolicy.default must be less than or equal to the maximum.

=cut

k8s min => Quantity, 'required';

=attr min

Min specifies the minimum capacity allowed for a consumption request. Min must be greater than or equal to zero, and less than or equal to the capacity value. requestPolicy.default must be more than or equal to the minimum.

=cut

k8s step => Quantity;

=attr step

Step defines the step size between valid capacity amounts within the range. Max (if set) and requestPolicy.default must be a multiple of Step. Min + Step must be less than or equal to the capacity value.

=cut

1;
