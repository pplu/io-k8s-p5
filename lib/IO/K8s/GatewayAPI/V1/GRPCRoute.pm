package IO::K8s::GatewayAPI::V1::GRPCRoute;
# ABSTRACT: Gateway API gRPC routing rules
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'grpcroutes';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Routable';

sub _route_format { 'gateway' }

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents a GRPCRoute resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). A GRPCRoute defines gRPC routing rules including service and method matching for routing gRPC traffic. GRPCRoute is a namespaced resource that attaches to Gateway listeners. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/grpcroute/> - Upstream GRPCRoute documentation

=item * L<IO::K8s::GatewayAPI::V1::Gateway> - Gateway that serves this route

=item * L<IO::K8s::GatewayAPI::V1::HTTPRoute> - HTTP routing alternative

=back

=cut
