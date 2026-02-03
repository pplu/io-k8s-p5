package IO::K8s::Api::Apps::V1::StatefulSetStatus;
# ABSTRACT: StatefulSetStatus represents the current state of a StatefulSet.

use IO::K8s::Resource;

k8s availableReplicas => Int;

=attr availableReplicas

Total number of available pods (ready for at least minReadySeconds) targeted by this statefulset.

=cut

k8s collisionCount => Int;

=attr collisionCount

collisionCount is the count of hash collisions for the StatefulSet. The StatefulSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.

=cut

k8s conditions => ['Apps::V1::StatefulSetCondition'];

=attr conditions

Represents the latest available observations of a statefulset's current state.

=cut

k8s currentReplicas => Int;

=attr currentReplicas

currentReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.

=cut

k8s currentRevision => Str;

=attr currentRevision

currentRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [0,currentReplicas).

=cut

k8s observedGeneration => Int;

=attr observedGeneration

observedGeneration is the most recent generation observed for this StatefulSet. It corresponds to the StatefulSet's generation, which is updated on mutation by the API Server.

=cut

k8s readyReplicas => Int;

=attr readyReplicas

readyReplicas is the number of pods created for this StatefulSet with a Ready Condition.

=cut

k8s replicas => Int, 'required';

=attr replicas

replicas is the number of Pods created by the StatefulSet controller.

=cut

k8s updateRevision => Str;

=attr updateRevision

updateRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [replicas-updatedReplicas,replicas)

=cut

k8s updatedReplicas => Int;

=attr updatedReplicas

updatedReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.

=cut

1;
