package IO::K8s::Api::Scheduling::V1alpha2::GangSchedulingPolicy;
# ABSTRACT: GangSchedulingPolicy defines the parameters for gang scheduling.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s minCount => Int, 'required';

=attr minCount

MinCount is the minimum number of pods that must be schedulable or scheduled at the same time for the scheduler to admit the entire group. It must be a positive integer.

=cut

1;
