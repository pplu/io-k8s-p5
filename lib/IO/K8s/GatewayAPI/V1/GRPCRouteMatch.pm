package IO::K8s::GatewayAPI::V1::GRPCRouteMatch;
# ABSTRACT: GRPCRouteMatch defines the predicate used to match requests to a given action.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s headers => ['+IO::K8s::GatewayAPI::V1::GRPCHeaderMatch'];
k8s method  => '+IO::K8s::GatewayAPI::V1::GRPCMethodMatch';

=attr headers

Headers specifies gRPC request header matchers. Multiple match values are
ANDed together, meaning, a request MUST match all the specified headers
to select the route.

=cut

=attr method

Method specifies a gRPC request service/method matcher. If this field is
not specified, all services and methods will match.

=cut

1;
