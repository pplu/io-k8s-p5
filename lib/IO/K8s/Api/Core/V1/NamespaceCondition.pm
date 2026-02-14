package IO::K8s::Api::Core::V1::NamespaceCondition;
# ABSTRACT: NamespaceCondition contains details about state of namespace.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s lastTransitionTime => Str;

k8s message => Str;

k8s reason => Str;

k8s status => Str, 'required';

=attr status

Status of the condition, one of True, False, Unknown.

=cut

k8s type => Str, 'required';

=attr type

Type of namespace controller condition.

=cut

1;
