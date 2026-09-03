package IO::K8s::GatewayAPI::V1::ReferenceGrantFrom;
# ABSTRACT: ReferenceGrantFrom describes trusted namespaces and kinds.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group     => Str, { required => 'schema', pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s kind      => Str, { required => 'schema', pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/ };
k8s namespace => Str, { required => 'schema', pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };

=attr group

Group is the group of the referent.
When empty, the Kubernetes core API group is inferred.

Support: Core

=cut

=attr kind

Kind is the kind of the referent. Although implementations may support
additional resources, the following types are part of the "Core"
support level for this field.

When used to permit a SecretObjectReference:

* Gateway

When used to permit a BackendObjectReference:

* GRPCRoute
* HTTPRoute
* TCPRoute
* TLSRoute
* UDPRoute

=cut

=attr namespace

Namespace is the namespace of the referent.

Support: Core

=cut

1;
