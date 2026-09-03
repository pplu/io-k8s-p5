package IO::K8s::GatewayAPI::V1beta1::HTTPRouteMatch;
# ABSTRACT: HTTPRouteMatch defines the predicate used to match requests to a given action.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s headers     => ['+IO::K8s::GatewayAPI::V1beta1::HTTPHeaderMatch'];
k8s method      => Str, { enum => [qw(GET HEAD POST PUT DELETE CONNECT OPTIONS TRACE PATCH)] };
k8s path        => '+IO::K8s::GatewayAPI::V1beta1::HTTPPathMatch', { default => {'type' => 'PathPrefix','value' => '/'} };
k8s queryParams => ['+IO::K8s::GatewayAPI::V1beta1::HTTPQueryParamMatch'];

=attr headers

Headers specifies HTTP request header matchers. Multiple match values are
ANDed together, meaning, a request must match all the specified headers
to select the route.

=cut

=attr method

Method specifies HTTP method matcher.
When specified, this route will be matched only if the request has the
specified method.

Support: Extended

=cut

=attr path

Path specifies a HTTP request path matcher. If this field is not
specified, a default prefix match on the "/" path is provided.

=cut

=attr queryParams

QueryParams specifies HTTP query parameter matchers. Multiple match
values are ANDed together, meaning, a request must match all the
specified query parameters to select the route.

Support: Extended

=cut

1;
