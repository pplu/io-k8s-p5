package IO::K8s::Api::Core::V1::NamespaceSpec;
# ABSTRACT: NamespaceSpec describes the attributes on a Namespace.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s finalizers => [Str];

=attr finalizers

Finalizers is an opaque list of values that must be empty to permanently remove object from storage. More info: https://kubernetes.io/docs/tasks/administer-cluster/namespaces/

=cut

1;
