package IO::K8s::PrometheusOperator::V1alpha1::NamespaceDiscovery;
# ABSTRACT: namespaces defines the namespace discovery.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s names        => [Str];
k8s ownNamespace => Bool;

=attr names

names defines a list of namespaces where to watch for resources.
If empty and `ownNamespace` isn't true, Prometheus watches for resources in all namespaces.

=cut

=attr ownNamespace

ownNamespace includes the namespace in which the Prometheus pod runs to the list of watched namespaces.

=cut

1;
