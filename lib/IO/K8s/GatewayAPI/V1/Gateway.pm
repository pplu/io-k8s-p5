package IO::K8s::GatewayAPI::V1::Gateway;
# ABSTRACT: Gateway API network gateway
our $VERSION = '1.002';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'gateways';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents a Gateway resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). A Gateway represents a network gateway instance with listeners for accepting traffic, typically acting as an entrypoint to a cluster. Gateway is a namespaced resource that references a GatewayClass for its configuration. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/gateway/> - Upstream Gateway documentation

=item * L<IO::K8s::GatewayAPI::V1::GatewayClass> - Gateway class definition

=item * L<IO::K8s::GatewayAPI::V1::HTTPRoute> - HTTP routing to this gateway

=item * L<IO::K8s::GatewayAPI::V1::GRPCRoute> - gRPC routing to this gateway

=back

=cut
