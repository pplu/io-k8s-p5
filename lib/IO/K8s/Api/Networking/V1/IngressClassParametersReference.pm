package IO::K8s::Api::Networking::V1::IngressClassParametersReference;
# ABSTRACT: IngressClassParametersReference identifies an API object. This can be used to specify a cluster or namespace-scoped resource.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s apiGroup => Str;

=attr apiGroup

apiGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.

=cut

k8s kind => Str, 'required';

=attr kind

kind is the type of resource being referenced.

=cut

k8s name => Str, 'required';

=attr name

name is the name of resource being referenced.

=cut

k8s namespace => Str;

=attr namespace

namespace is the namespace of the resource being referenced. This field is required when scope is set to "Namespace" and must be unset when scope is set to "Cluster".

=cut

k8s scope => Str;

=attr scope

scope represents if this refers to a cluster or namespace scoped resource. This may be set to "Cluster" (default) or "Namespace".

=cut

1;
