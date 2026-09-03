package IO::K8s::GatewayAPI::V1::GRPCMethodMatch;
# ABSTRACT: Method specifies a gRPC request service/method matcher.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s method  => Str;
k8s service => Str;
k8s type    => Str, { enum => [qw(Exact RegularExpression)], default => 'Exact' };

=attr method

Value of the method to match against. If left empty or omitted, will
match all services.

At least one of Service and Method MUST be a non-empty string.

=cut

=attr service

Value of the service to match against. If left empty or omitted, will
match any service.

At least one of Service and Method MUST be a non-empty string.

=cut

=attr type

Type specifies how to match against the service and/or method.
Support: Core (Exact with service and method specified)

Support: Implementation-specific (Exact with method specified but no service specified)

Support: Implementation-specific (RegularExpression)

=cut

1;
