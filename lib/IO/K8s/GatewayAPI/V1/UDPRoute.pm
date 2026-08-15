package IO::K8s::GatewayAPI::V1::UDPRoute;
# ABSTRACT: Gateway API raw UDP routing rules
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'udproutes';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents a UDPRoute resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). A UDPRoute routes raw L4 UDP traffic purely by C<parentRef> and listener port, forwarding to backends via C<rules[].backendRefs>. Like TCPRoute, it has no hostname field to match on, so it does not consume L<IO::K8s::Role::Routable> (whose C<add_hostname> assumes a C<spec.hostnames> field). UDPRoute is a namespaced resource that attaches to Gateway listeners. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/udproute/> - Upstream UDPRoute documentation

=item * L<IO::K8s::GatewayAPI::V1::Gateway> - Gateway that serves this route

=item * L<IO::K8s::GatewayAPI::V1::TCPRoute> - Raw TCP routing counterpart

=back

=cut
