package IO::K8s::PrometheusOperator::V1::AttachMetadata;
# ABSTRACT: attachMetadata defines additional metadata which is added to the discovered targets.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s node => Bool;

=attr node

node when set to true, Prometheus attaches node metadata to the discovered
targets.

The Prometheus service account must have the `list` and `watch`
permissions on the `Nodes` objects.

Node metadata labels are not automatically added to scraped metrics. They are
exposed as `__meta_kubernetes_node_*` labels and can be copied to timeseries
with relabeling configuration.

=cut

1;
