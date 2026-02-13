package IO::K8s::Api::Core::V1::TypedLocalObjectReference;
# ABSTRACT: TypedLocalObjectReference contains enough information to let you locate the typed referenced object inside the same namespace.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s apiGroup => Str;

=attr apiGroup

APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.

=cut

k8s kind => Str, 'required';

=attr kind

Kind is the type of resource being referenced

=cut

k8s name => Str, 'required';

=attr name

Name is the name of resource being referenced

=cut

1;
