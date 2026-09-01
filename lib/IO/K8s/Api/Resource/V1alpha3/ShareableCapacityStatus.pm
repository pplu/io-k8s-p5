package IO::K8s::Api::Resource::V1alpha3::ShareableCapacityStatus;
# ABSTRACT: ShareableCapacityStatus reports aggregate amounts for a single shareable capacity key.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s available => Quantity, 'required';

=attr available

Available is Total minus Consumed, never negative.

=cut

k8s consumed => Quantity, 'required';

=attr consumed

Consumed is the amount drawn by current allocations.

=cut

k8s name => Str, 'required';

=attr name

Name is the capacity name.

=cut

k8s total => Quantity, 'required';

=attr total

Total is the sum of this capacity across shareable devices in the pool.

=cut

1;
