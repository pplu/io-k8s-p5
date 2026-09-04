package IO::K8s::PrometheusOperator::V1alpha1::AttachMetadata;
# ABSTRACT: attachMetadata defines the metadata to attach to discovered targets.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s node => Bool;

=attr node

node attaches node metadata to discovered targets.
When set to true, Prometheus must have the `get` permission on the
`Nodes` objects.
Only valid for Pod, Endpoint and Endpointslice roles.

=cut

1;
