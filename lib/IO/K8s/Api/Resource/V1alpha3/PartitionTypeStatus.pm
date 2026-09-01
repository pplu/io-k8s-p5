package IO::K8s::Api::Resource::V1alpha3::PartitionTypeStatus;
# ABSTRACT: PartitionTypeStatus reports allocatability for a single partition type, identified by the value of a grouping attribute.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s allocatable => Int, 'required';

=attr allocatable

Allocatable is the number of additional devices of this partition type that could still be allocated given current shared-counter consumption.

=cut

k8s attribute => Str, 'required';

=attr attribute

Attribute is the fully qualified name of the device attribute whose value groups this entry. It is the PartitionTypeAttribute declared by the devices' own slice, or the default named in the request when their slice declares none.

=cut

k8s total => Int, 'required';

=attr total

Total is the number of devices of this partition type in the pool.

=cut

k8s type => Str, 'required';

=attr type

Type is the partition type value (e.g. "Full" or "Half").

=cut

1;
