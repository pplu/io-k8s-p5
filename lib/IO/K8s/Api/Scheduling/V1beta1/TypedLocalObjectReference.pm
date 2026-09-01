package IO::K8s::Api::Scheduling::V1beta1::TypedLocalObjectReference;
# ABSTRACT: TypedLocalObjectReference allows to reference typed object inside the same namespace.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apiGroup => Str;

=attr apiGroup

apiGroup is the group for the resource being referenced. If apiGroup is empty, the specified Kind must be in the core API group. For any other third-party types, setting apiGroup is required. It must be a DNS subdomain.

=cut

k8s kind => Str, 'required';

=attr kind

kind is the type of resource being referenced. It must be a path segment name.

=cut

k8s name => Str, 'required';

=attr name

name is the name of resource being referenced. It must be a path segment name.

=cut

1;
