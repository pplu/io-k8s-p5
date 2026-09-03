package IO::K8s::GatewayAPI::V1beta1::BackendObjectReference;
# ABSTRACT: BackendRef references a resource where mirrored requests are sent.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group     => Str, { pattern => qr/^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/, default => '' };
k8s kind      => Str, { pattern => qr/^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$/, default => 'Service' };
k8s name      => Str, { required => 'schema' };
k8s namespace => Str, { pattern => qr/^[a-z0-9]([-a-z0-9]*[a-z0-9])?$/ };
k8s port      => Int, { minimum => 1, maximum => 65535 };

=attr group

Group is the group of the referent. For example, "gateway.networking.k8s.io".
When unspecified or empty string, core API group is inferred.

=cut

=attr kind

Kind is the Kubernetes resource kind of the referent. For example
"Service".

Defaults to "Service" when not specified.

ExternalName services can refer to CNAME DNS records that may live
outside of the cluster and as such are difficult to reason about in
terms of conformance. They also may not be safe to forward to (see
CVE-2021-25740 for more information). Implementations SHOULD NOT
support ExternalName Services.

Support: Core (Services with a type other than ExternalName)

Support: Implementation-specific (Services with type ExternalName)

=cut

=attr name

Name is the name of the referent.

=cut

=attr namespace

Namespace is the namespace of the backend. When unspecified, the local
namespace is inferred.

Note that when a namespace different than the local namespace is specified,
a ReferenceGrant object is required in the referent namespace to allow that
namespace's owner to accept the reference. See the ReferenceGrant
documentation for details.

Support: Core

=cut

=attr port

Port specifies the destination port number to use for this resource.
Port is required when the referent is a Kubernetes Service. In this
case, the port number is the service port number, not the target port.
For other resources, destination port might be derived from the referent
resource or this field.

=cut

1;
