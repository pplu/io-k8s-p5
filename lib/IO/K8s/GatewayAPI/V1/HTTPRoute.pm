package IO::K8s::GatewayAPI::V1::HTTPRoute;
# ABSTRACT: Gateway API HTTP routing rules
our $VERSION = '1.003';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'httproutes';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Routable';

sub _route_format { 'gateway' }

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents an HTTPRoute resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). An HTTPRoute defines HTTP routing rules including host matching, path matching, header manipulation, and backend service references. HTTPRoute is a namespaced resource that attaches to Gateway listeners. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/httproute/> - Upstream HTTPRoute documentation

=item * L<IO::K8s::GatewayAPI::V1::Gateway> - Gateway that serves this route

=item * L<IO::K8s::GatewayAPI::V1::GRPCRoute> - gRPC routing alternative

=back

=cut
