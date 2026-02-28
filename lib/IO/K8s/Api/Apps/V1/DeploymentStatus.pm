package IO::K8s::Api::Apps::V1::DeploymentStatus;
# ABSTRACT: DeploymentStatus is the most recently observed status of the Deployment.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s availableReplicas => Int;

=attr availableReplicas

Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.

=cut

k8s collisionCount => Int;

=attr collisionCount

Count of hash collisions for the Deployment. The Deployment controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ReplicaSet.

=cut

k8s conditions => ['Apps::V1::DeploymentCondition'];

=attr conditions

Represents the latest available observations of a deployment's current state.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

The generation observed by the deployment controller.

=cut

k8s readyReplicas => Int;

=attr readyReplicas

readyReplicas is the number of pods targeted by this Deployment with a Ready Condition.

=cut

k8s replicas => Int;

=attr replicas

Total number of non-terminated pods targeted by this deployment (their labels match the selector).

=cut

k8s unavailableReplicas => Int;

=attr unavailableReplicas

Total number of unavailable pods targeted by this deployment. This is the total number of pods that are still required for the deployment to have 100% available capacity. They may either be pods that are running but not yet available or pods that still have not been created.

=cut

k8s updatedReplicas => Int;

=attr updatedReplicas

Total number of non-terminated pods targeted by this deployment that have the desired template spec.

=cut

1;
