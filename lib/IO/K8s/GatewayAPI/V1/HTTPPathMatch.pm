package IO::K8s::GatewayAPI::V1::HTTPPathMatch;
# ABSTRACT: Path specifies a HTTP request path matcher.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s type  => Str, { enum => [qw(Exact PathPrefix RegularExpression)], default => 'PathPrefix' };
k8s value => Str, { default => '/' };

=attr type

Type specifies how to match against the path Value.

Support: Core (Exact, PathPrefix)

Support: Implementation-specific (RegularExpression)

=cut

=attr value

Value of the HTTP path to match against.

=cut

1;
