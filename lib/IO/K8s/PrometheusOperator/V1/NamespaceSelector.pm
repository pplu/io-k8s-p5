package IO::K8s::PrometheusOperator::V1::NamespaceSelector;
# ABSTRACT: namespaceSelector defines in which namespace(s) Prometheus should discover the services.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s any        => Bool;
k8s matchNames => [Str];

=attr any

any defines the boolean describing whether all namespaces are selected in contrast to a
list restricting them.

=cut

=attr matchNames

matchNames defines the list of namespace names to select from.

=cut

1;
