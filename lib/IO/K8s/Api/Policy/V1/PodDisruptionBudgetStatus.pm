package IO::K8s::Api::Policy::V1::PodDisruptionBudgetStatus;
# ABSTRACT: PodDisruptionBudgetStatus represents information about the status of a PodDisruptionBudget. Status may trail the actual state of a system.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'];

=attr conditions

Conditions contain conditions for PDB. The disruption controller sets the DisruptionAllowed condition. The following are known values for the reason field (additional reasons could be added in the future): - SyncFailed: The controller encountered an error and wasn't able to compute the number of allowed disruptions. Therefore no disruptions are allowed and the status of the condition will be False. - InsufficientPods: The number of pods are either at or below the number required by the PodDisruptionBudget. No disruptions are allowed and the status of the condition will be False. - SufficientPods: There are more pods than required by the PodDisruptionBudget. The condition will be True, and the number of allowed disruptions are provided by the disruptionsAllowed property.

=cut

k8s currentHealthy => Int, 'required';

=attr currentHealthy

current number of healthy pods

=cut

k8s desiredHealthy => Int, 'required';

=attr desiredHealthy

minimum desired number of healthy pods

=cut

k8s disruptedPods => { Str => 1 };

=attr disruptedPods

DisruptedPods contains information about pods whose eviction was processed by the API server eviction subresource handler but has not yet been observed by the PodDisruptionBudget controller. A pod will be in this map from the time when the API server processed the eviction request to the time when the pod is seen by PDB controller as having been marked for deletion (or after a timeout). The key in the map is the name of the pod and the value is the time when the API server processed the eviction request. If the deletion didn't occur and a pod is still there it will be removed from the list automatically by PodDisruptionBudget controller after some time. If everything goes smooth this map should be empty for the most of the time. Large number of entries in the map may indicate problems with pod deletions.

=cut

k8s disruptionsAllowed => Int, 'required';

=attr disruptionsAllowed

Number of pod disruptions that are currently allowed.

=cut

k8s expectedPods => Int, 'required';

=attr expectedPods

total number of pods counted by this disruption budget

=cut

k8s observedGeneration => Int;

=attr observedGeneration

Most recent generation observed when updating this PDB status. DisruptionsAllowed and other status information is valid only if observedGeneration equals to PDB's object generation.

=cut

1;
