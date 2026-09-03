package IO::K8s::GatewayAPI::V1::ObjectReference;
# ABSTRACT: ObjectReference identifies an API object including its namespace.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group     => Str, { required => 'schema', pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s kind      => Str, { required => 'schema', pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/ };
k8s name      => Str, { required => 'schema' };
k8s namespace => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };

=attr group

Group is the group of the referent. For example, "gateway.networking.k8s.io".
When set to the empty string, core API group is inferred.

=cut

=attr kind

Kind is kind of the referent. For example "ConfigMap" or "Service".

=cut

=attr name

Name is the name of the referent.

=cut

=attr namespace

Namespace is the namespace of the referenced object. When unspecified, the local
namespace is inferred.

Note that when a namespace different than the local namespace is specified,
a ReferenceGrant object is required in the referent namespace to allow that
namespace's owner to accept the reference. See the ReferenceGrant
documentation for details.

Support: Core

=cut

1;
