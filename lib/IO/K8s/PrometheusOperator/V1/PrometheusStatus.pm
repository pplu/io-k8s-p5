package IO::K8s::PrometheusOperator::V1::PrometheusStatus;
# ABSTRACT: status defines the most recent observed status of the Prometheus cluster.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s availableReplicas   => Int;
k8s conditions          => ['Meta::V1::Condition'];
k8s paused              => Bool;
k8s replicas            => Int;
k8s selector            => Str;
k8s shardStatuses       => ['+IO::K8s::PrometheusOperator::V1::ShardStatus'];
k8s shards              => Int;
k8s unavailableReplicas => Int;
k8s updatedReplicas     => Int;

=attr availableReplicas

availableReplicas defines the total number of available pods (ready for at least minReadySeconds)
targeted by this Prometheus deployment.

=cut

=attr conditions

conditions defines the current state of the Prometheus deployment.

=cut

=attr paused

paused defines whether any actions on the underlying managed objects are
being performed. Only delete actions will be performed.

=cut

=attr replicas

replicas defines the total number of non-terminated pods targeted by this Prometheus deployment
(their labels match the selector).

=cut

=attr selector

selector used to match the pods targeted by this Prometheus resource.

=cut

=attr shardStatuses

shardStatuses defines the list has one entry per shard. Each entry provides a summary of the shard status.

=cut

=attr shards

shards defines the most recently observed number of shards.

=cut

=attr unavailableReplicas

unavailableReplicas defines the total number of unavailable pods targeted by this Prometheus deployment.

=cut

=attr updatedReplicas

updatedReplicas defines the total number of non-terminated pods targeted by this Prometheus deployment
that have the desired version spec.

=cut

1;
