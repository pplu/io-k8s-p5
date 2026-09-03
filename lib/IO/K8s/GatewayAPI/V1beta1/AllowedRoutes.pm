package IO::K8s::GatewayAPI::V1beta1::AllowedRoutes;
# ABSTRACT: AllowedRoutes defines the types of routes that MAY be attached to a Listener and the trusted namespaces where those Route resources MAY be present.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kinds      => ['+IO::K8s::GatewayAPI::V1beta1::RouteGroupKind'];
k8s namespaces => '+IO::K8s::GatewayAPI::V1beta1::RouteNamespaces', { default => {'from' => 'Same'} };

=attr kinds

Kinds specifies the groups and kinds of Routes that are allowed to bind
to this Gateway Listener. When unspecified or empty, the kinds of Routes
selected are determined using the Listener protocol.

A RouteGroupKind MUST correspond to kinds of Routes that are compatible
with the application protocol specified in the Listener's Protocol field.
If an implementation does not support or recognize this resource type, it
MUST set the "ResolvedRefs" condition to False for this Listener with the
"InvalidRouteKinds" reason.

Support: Core

=cut

=attr namespaces

Namespaces indicates namespaces from which Routes may be attached to this
Listener. This is restricted to the namespace of this Gateway by default.

Support: Core

=cut

1;
