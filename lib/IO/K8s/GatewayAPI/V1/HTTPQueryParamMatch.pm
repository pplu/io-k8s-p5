package IO::K8s::GatewayAPI::V1::HTTPQueryParamMatch;
# ABSTRACT: HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP query parameters.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name  => Str, { required => 'schema', pattern => qr/^[A-Za-z0-9!#\$%&'*+\-.^_\x60|~]+$/ };
k8s type  => Str, { enum => [qw(Exact RegularExpression)], default => 'Exact' };
k8s value => Str, { required => 'schema' };

=attr name

Name is the name of the HTTP query param to be matched. This must be an
exact string match. (See
https://tools.ietf.org/html/rfc7230#section-2.7.3).

If multiple entries specify equivalent query param names, only the first
entry with an equivalent name MUST be considered for a match. Subsequent
entries with an equivalent query param name MUST be ignored.

If a query param is repeated in an HTTP request, the behavior is
purposely left undefined, since different data planes have different
capabilities. However, it is *recommended* that implementations should
match against the first value of the param if the data plane supports it,
as this behavior is expected in other load balancing contexts outside of
the Gateway API.

Users SHOULD NOT route traffic based on repeated query params to guard
themselves against potential differences in the implementations.

=cut

=attr type

Type specifies how to match against the value of the query parameter.

Support: Extended (Exact)

Support: Implementation-specific (RegularExpression)

Since RegularExpression QueryParamMatchType has Implementation-specific
conformance, implementations can support POSIX, PCRE or any other
dialects of regular expressions. Please read the implementation's
documentation to determine the supported dialect.

=cut

=attr value

Value is the value of HTTP query param to be matched.

=cut

1;
