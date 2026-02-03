package IO::K8s::Api::Core::V1::TypedObjectReference;
# ABSTRACT: 

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

k8s namespace => Str;

=attr namespace

Namespace is the namespace of resource being referenced Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. (Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.

=cut

1;
