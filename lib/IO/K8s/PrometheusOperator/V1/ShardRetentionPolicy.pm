package IO::K8s::PrometheusOperator::V1::ShardRetentionPolicy;
# ABSTRACT: shardRetentionPolicy defines the retention policy for the Prometheus shards.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s retain     => '+IO::K8s::PrometheusOperator::V1::RetainConfig';
k8s whenScaled => Str, { enum => [qw(Retain Delete)] };

=attr retain

retain defines the config for retention when the retention policy is set
to `Retain`.

If not defined, the operator will use the retention duration configured
for the Prometheus data. If the resource uses size-based retention, the
shard(s) are kept forever (unless manually deleted).

=cut

=attr whenScaled

whenScaled defines the retention policy when the Prometheus shards are scaled down.
* `Delete`, the operator will delete the pods from the scaled-down shard(s).
* `Retain`, the operator will keep the pods from the scaled-down shard(s), so the data can still be queried.

If not defined, the operator assumes the `Delete` value.

=cut

1;
