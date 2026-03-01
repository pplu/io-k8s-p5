package IO::K8s::Api::Core::V1::NamespaceStatus;
# ABSTRACT: NamespaceStatus is information about the current status of a Namespace.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s conditions => ['Core::V1::NamespaceCondition'];

=attr conditions

Represents the latest available observations of a namespace's current state.

=cut

k8s phase => Str;

=attr phase

Phase is the current lifecycle phase of the namespace. More info: https://kubernetes.io/docs/tasks/administer-cluster/namespaces/

=cut

1;
