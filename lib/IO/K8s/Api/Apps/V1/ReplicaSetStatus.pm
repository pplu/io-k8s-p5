package IO::K8s::Api::Apps::V1::ReplicaSetStatus;
# ABSTRACT: ReplicaSetStatus represents the current status of a ReplicaSet.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s availableReplicas => Int;

=attr availableReplicas

The number of available replicas (ready for at least minReadySeconds) for this replica set.

=cut

k8s conditions => ['Apps::V1::ReplicaSetCondition'];

=attr conditions

Represents the latest available observations of a replica set's current state.

=cut

k8s fullyLabeledReplicas => Int;

=attr fullyLabeledReplicas

The number of pods that have labels matching the labels of the pod template of the replicaset.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

ObservedGeneration reflects the generation of the most recently observed ReplicaSet.

=cut

k8s readyReplicas => Int;

=attr readyReplicas

readyReplicas is the number of pods targeted by this ReplicaSet with a Ready Condition.

=cut

k8s replicas => Int, 'required';

=attr replicas

Replicas is the most recently observed number of replicas. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#what-is-a-replicationcontroller

=cut

1;
