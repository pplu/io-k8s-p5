package IO::K8s::Api::Scheduling::V1beta1::CompositeGangSchedulingPolicy;
# ABSTRACT: CompositeGangSchedulingPolicy indicates that the groups belonging to the composite group should be scheduled using all-or-nothing semantics.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s minGroupCount => Int, 'required';

=attr minGroupCount

minGroupCount is the minimum number of child groups that must be schedulable or scheduled at the same time for the scheduler to admit the entire group. It must be a positive integer.

=cut

1;
