package IO::K8s::GatewayAPI::V1beta1::ReferenceGrantTo;
# ABSTRACT: ReferenceGrantTo describes what Kinds are allowed as targets of the references.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group => Str, { required => 'schema', pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s kind  => Str, { required => 'schema', pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/ };
k8s name  => Str;

=attr group

Group is the group of the referent.
When empty, the Kubernetes core API group is inferred.

Support: Core

=cut

=attr kind

Kind is the kind of the referent. Although implementations may support
additional resources, the following types are part of the "Core"
support level for this field:

* Secret when used to permit a SecretObjectReference
* Service when used to permit a BackendObjectReference

=cut

=attr name

Name is the name of the referent. When unspecified, this policy
refers to all resources of the specified Group and Kind in the local
namespace.

=cut

1;
