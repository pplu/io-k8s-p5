package IO::K8s::PrometheusOperator::V1::ShardingStrategy;
# ABSTRACT: shardingStrategy defines the sharding strategy for distributing scraped targets across Prometheus shards.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mode     => Str, { enum => [qw(Address Topology)] };
k8s topology => '+IO::K8s::PrometheusOperator::V1::TopologyShardingStrategy';

=attr mode

mode defines the sharding mode. Can be 'Address' or 'Topology'.

'Address' is the default mode and distributes targets across shards
based on a hash of the target address.

'Topology' enables zone-aware sharding where each shard is assigned to a
specific topology zone and only scrapes targets in that zone.
(Alpha) Using the 'Topology' mode requires the `PrometheusTopologySharding`
feature gate to be enabled.

=cut

=attr topology

topology defines the configuration for topology-aware sharding.
This field is only valid when mode is set to 'Topology'.

=cut

1;
