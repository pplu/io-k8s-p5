package IO::K8s::PrometheusOperator::V1::TopologyShardingStrategy;
# ABSTRACT: topology defines the configuration for topology-aware sharding.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s externalLabelName => Str;
k8s values            => [Str];

=attr externalLabelName

externalLabelName defines the name of the Prometheus external label used
to communicate the topology zone assigned to the Prometheus instance.
If not defined, it defaults to "zone".
If set to the empty string, no external label is added to the Prometheus configuration.

=cut

=attr values

values defines the list of topology values (e.g. zone names) to be used
for sharding. The configured number of shards must be greater than or
equal to the number of values.

=cut

1;
