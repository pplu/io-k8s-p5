package IO::K8s::PrometheusOperator::V1::ShardStatus;
# ABSTRACT: ShardStatus
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s availableReplicas   => Int, { required => 'schema' };
k8s replicas            => Int, { required => 'schema' };
k8s shardID             => Str, { required => 'schema' };
k8s unavailableReplicas => Int, { required => 'schema' };
k8s updatedReplicas     => Int, { required => 'schema' };

=attr availableReplicas

availableReplicas defines the total number of available pods (ready for at least minReadySeconds)
targeted by this shard.

=cut

=attr replicas

replicas defines the total number of pods targeted by this shard.

=cut

=attr shardID

shardID defines the identifier of the shard.

=cut

=attr unavailableReplicas

unavailableReplicas defines the Total number of unavailable pods targeted by this shard.

=cut

=attr updatedReplicas

updatedReplicas defines the total number of non-terminated pods targeted by this shard
that have the desired spec.

=cut

1;
