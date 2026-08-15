package IO::K8s::GatewayAPI::V1::BackendTLSPolicy;
# ABSTRACT: Gateway API TLS policy for connections to a backend
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'backendtlspolicies';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents a BackendTLSPolicy resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). A BackendTLSPolicy configures TLS from a Gateway to a backend, including target references, certificate validation (CA certificates or well-known CA bundles), and the expected hostname or subject alternative names. BackendTLSPolicy is a namespaced resource. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/backendtlspolicy/> - Upstream BackendTLSPolicy documentation

=item * L<IO::K8s::GatewayAPI::V1::Gateway> - Gateway that may enforce this policy

=item * L<IO::K8s::GatewayAPI::V1::HTTPRoute> - Route whose backends this policy secures

=back

=cut
