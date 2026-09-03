package IO::K8s::GatewayAPI::V1::TLSRouteSpec;
# ABSTRACT: Spec defines the desired state of TLSRoute.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s hostnames  => [Str], { required => 'schema', pattern => qr/^(\*\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$/ };
k8s parentRefs => ['+IO::K8s::GatewayAPI::V1::ParentReference'];
k8s rules      => ['+IO::K8s::GatewayAPI::V1::TLSRouteRule'], { required => 'schema' };

=attr hostnames

Hostnames defines a set of SNI hostnames that should match against the
SNI attribute of TLS ClientHello message in TLS handshake. This matches
the RFC 1123 definition of a hostname with 2 notable exceptions:

1. IPs are not allowed in SNI hostnames per RFC 6066.
2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
   label must appear by itself as the first label.

=cut

=attr parentRefs

ParentRefs references the resources (usually Gateways) that a Route wants
to be attached to. Note that the referenced parent resource needs to
allow this for the attachment to be complete. For Gateways, that means
the Gateway needs to allow attachment from Routes of this kind and
namespace. For Services, that means the Service must either be in the same
namespace for a "producer" route, or the mesh implementation must support
and allow "consumer" routes for the referenced Service. ReferenceGrant is
not applicable for governing ParentRefs to Services - it is not possible to
create a "producer" route for a Service in a different namespace from the
Route.

There are two kinds of parent resources with "Core" support:

* Gateway (Gateway conformance profile)
* Service (Mesh conformance profile, ClusterIP Services only)

This API may be extended in the future to support additional kinds of parent
resources.

ParentRefs must be _distinct_. This means either that:

* They select different objects.  If this is the case, then parentRef
  entries are distinct. In terms of fields, this means that the
  multi-part key defined by `group`, `kind`, `namespace`, and `name` must
  be unique across all parentRef entries in the Route.
* They do not select different objects, but for each optional field used,
  each ParentRef that selects the same object must set the same set of
  optional fields to different values. If one ParentRef sets a
  combination of optional fields, all must set the same combination.

Some examples:

* If one ParentRef sets `sectionName`, all ParentRefs referencing the
  same object must also set `sectionName`.
* If one ParentRef sets `port`, all ParentRefs referencing the same
  object must also set `port`.
* If one ParentRef sets `sectionName` and `port`, all ParentRefs
  referencing the same object must also set `sectionName` and `port`.

It is possible to separately reference multiple distinct objects that may
be collapsed by an implementation. For example, some implementations may
choose to merge compatible Gateway Listeners together. If that is the
case, the list of routes attached to those resources should also be
merged.

Note that for ParentRefs that cross namespace boundaries, there are specific
rules. Cross-namespace references are only valid if they are explicitly
allowed by something in the namespace they are referring to. For example,
Gateway has the AllowedRoutes field, and ReferenceGrant provides a
generic way to enable other kinds of cross-namespace reference.

=cut

=attr rules

Rules are a list of actions.

=cut

1;
