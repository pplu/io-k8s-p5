package IO::K8s::GatewayAPI::V1::GRPCHeaderMatch;
# ABSTRACT: GRPCHeaderMatch describes how to select a gRPC route by matching gRPC request headers.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name  => Str, { required => 'schema', pattern => qr/^[A-Za-z0-9!#\$%&'*+\-.^_\x60|~]+$/ };
k8s type  => Str, { enum => [qw(Exact RegularExpression)], default => 'Exact' };
k8s value => Str, { required => 'schema' };

=attr name

Name is the name of the gRPC Header to be matched.

If multiple entries specify equivalent header names, only the first
entry with an equivalent name MUST be considered for a match. Subsequent
entries with an equivalent header name MUST be ignored. Due to the
case-insensitivity of header names, "foo" and "Foo" are considered
equivalent.

=cut

=attr type

Type specifies how to match against the value of the header.

=cut

=attr value

Value is the value of the gRPC Header to be matched.

=cut

1;
