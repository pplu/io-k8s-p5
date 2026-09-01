package IO::K8s::Api::Scheduling::V1alpha3::WorkloadPodGroupGangSchedulingPolicy;
# ABSTRACT: WorkloadPodGroupGangSchedulingPolicy defines the parameters for gang (all-or-nothing) scheduling.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s minCount => Int;

=attr minCount

minCount is the minimum number of pods that must be scheduled at the same time for the scheduler to admit the entire group. This field is optional. If it is not specified, the controller should inject a context-specific sane default (e.g., parallelism for a Job). If set, it must be a positive integer.

=cut

1;
