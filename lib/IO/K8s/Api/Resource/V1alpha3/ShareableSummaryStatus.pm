package IO::K8s::Api::Resource::V1alpha3::ShareableSummaryStatus;
# ABSTRACT: ShareableSummaryStatus reports aggregate capacity for a pool that contains devices with AllowMultipleAllocations.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s capacity => ['Resource::V1alpha3::ShareableCapacityStatus'];

=attr capacity

Capacity reports aggregate total, consumed, and available amounts per shareable capacity key across the pool.

=cut

k8s fullyAvailableDevices => Int, 'required';

=attr fullyAvailableDevices

FullyAvailableDevices is the number of shareable devices with no capacity consumed.

=cut

k8s partiallyAvailableDevices => Int, 'required';

=attr partiallyAvailableDevices

PartiallyAvailableDevices is the number of shareable devices with some but not all capacity consumed.

=cut

1;
