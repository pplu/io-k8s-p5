package IO::K8s::Api::Core::V1::ReplicationControllerStatus;
# ABSTRACT: ReplicationControllerStatus represents the current status of a replication controller.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s availableReplicas => Int;

=attr availableReplicas

The number of available replicas (ready for at least minReadySeconds) for this replication controller.

=cut

k8s conditions => ['Core::V1::ReplicationControllerCondition'];

=attr conditions

Represents the latest available observations of a replication controller's current state.

=cut

k8s fullyLabeledReplicas => Int;

=attr fullyLabeledReplicas

The number of pods that have labels matching the labels of the pod template of the replication controller.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

ObservedGeneration reflects the generation of the most recently observed replication controller.

=cut

k8s readyReplicas => Int;

=attr readyReplicas

The number of ready replicas for this replication controller.

=cut

k8s replicas => Int, 'required';

=attr replicas

Replicas is the most recently observed number of replicas. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#what-is-a-replicationcontroller

=cut

1;
