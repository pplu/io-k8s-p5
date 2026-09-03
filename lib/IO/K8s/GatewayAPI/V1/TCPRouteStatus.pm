package IO::K8s::GatewayAPI::V1::TCPRouteStatus;
# ABSTRACT: Status defines the current state of TCPRoute.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s parents => ['+IO::K8s::GatewayAPI::V1::RouteParentStatus'], { required => 'schema' };

=attr parents

Parents is a list of parent resources (usually Gateways) that are
associated with the route, and the status of the route with respect to
each parent. When this route attaches to a parent, the controller that
manages the parent must add an entry to this list when the controller
first sees the route and should update the entry as appropriate when the
route or gateway is modified.

Note that parent references that cannot be resolved by an implementation
of this API will not be added to this list. Implementations of this API
can only populate Route status for the Gateways/parent resources they are
responsible for.

A maximum of 32 Gateways will be represented in this list. An empty list
means the route has not been attached to any Gateway.

=cut

1;
