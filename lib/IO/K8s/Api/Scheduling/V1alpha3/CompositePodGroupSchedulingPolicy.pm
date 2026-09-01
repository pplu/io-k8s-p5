package IO::K8s::Api::Scheduling::V1alpha3::CompositePodGroupSchedulingPolicy;
# ABSTRACT: CompositePodGroupSchedulingPolicy defines the scheduling configuration for a CompositePodGroup. Exactly one policy must be set.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s basic => 'Scheduling::V1alpha3::CompositeBasicSchedulingPolicy';

=attr basic

basic specifies that the groups of this composite group should be scheduled independently. This field is immutable.

=cut

k8s gang => 'Scheduling::V1alpha3::CompositeGangSchedulingPolicy';

=attr gang

gang specifies that the groups of this composite group should be scheduled using all-or-nothing semantics.

=cut

1;
