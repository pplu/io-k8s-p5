package IO::K8s::Api::Scheduling::V1beta1::PodGroupStatus;
# ABSTRACT: PodGroupStatus represents information about the status of a pod group.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

conditions represent the latest observations of the PodGroup's state.

Known condition types: - "PodGroupInitiallyScheduled": Indicates whether the scheduling requirement has been satisfied. Once this condition transitions to True, it serves as a terminal state and will never revert to False, even if pods are subsequently evicted and group constraints are no longer met. - "DisruptionTarget": Indicates whether the PodGroup is about to be terminated
  due to disruption such as preemption.

Known reasons for the PodGroupInitiallyScheduled condition: - "Unschedulable": The PodGroup cannot be scheduled due to resource constraints,
  affinity/anti-affinity rules, or insufficient capacity for the gang.
- "SchedulerError": The PodGroup cannot be scheduled due to some internal error
  that happened during scheduling, for example due to nodeAffinity parsing errors.

Known reasons for the DisruptionTarget condition: - "PreemptionByScheduler": The PodGroup was preempted by the scheduler to make room for
  higher-priority PodGroups or Pods.

=cut

k8s resourceClaimStatuses => ['Scheduling::V1beta1::PodGroupResourceClaimStatus'];

=attr resourceClaimStatuses

resourceClaimStatuses is status of resource claims.

=cut

1;
