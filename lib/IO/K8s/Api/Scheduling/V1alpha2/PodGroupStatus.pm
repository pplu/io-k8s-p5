package IO::K8s::Api::Scheduling::V1alpha2::PodGroupStatus;
# ABSTRACT: PodGroupStatus represents information about the status of a pod group.
our $VERSION = '1.106';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

Conditions represent the latest observations of the PodGroup's state.

Known condition types:

=over 4

=item * "PodGroupScheduled": Indicates whether the scheduling requirement has been satisfied.

=item * "DisruptionTarget": Indicates whether the PodGroup is about to be terminated due to disruption such as preemption.

=back

Known reasons for the PodGroupScheduled condition:

=over 4

=item * "Unschedulable": The PodGroup cannot be scheduled due to resource constraints, affinity/anti-affinity rules, or insufficient capacity for the gang.

=item * "SchedulerError": The PodGroup cannot be scheduled due to some internal error that happened during scheduling, for example due to nodeAffinity parsing errors.

=back

Known reasons for the DisruptionTarget condition:

=over 4

=item * "PreemptionByScheduler": The PodGroup was preempted by the scheduler to make room for higher-priority PodGroups or Pods.

=back

=cut

k8s resourceClaimStatuses => ['Scheduling::V1alpha2::PodGroupResourceClaimStatus'];

=attr resourceClaimStatuses

Status of resource claims.

=cut

1;
