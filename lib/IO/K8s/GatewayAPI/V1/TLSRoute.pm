package IO::K8s::GatewayAPI::V1::TLSRoute;
# ABSTRACT: Gateway API TLS SNI routing rules
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'tlsroutes';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Routable';

sub _route_format { 'gateway' }

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents a TLSRoute resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). A TLSRoute routes TLS traffic based on the SNI hostname, supporting Passthrough or Terminate listener modes, and forwards to backends via C<rules[].backendRefs>. Like HTTPRoute, it matches on a top-level C<spec.hostnames> list, so it consumes L<IO::K8s::Role::Routable> for C<add_hostname>/C<add_backend> helpers; unlike HTTPRoute it has no path or header matching. TLSRoute is a namespaced resource that attaches to Gateway listeners. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/tlsroute/> - Upstream TLSRoute documentation

=item * L<IO::K8s::GatewayAPI::V1::Gateway> - Gateway that serves this route

=item * L<IO::K8s::GatewayAPI::V1::TCPRoute> - Raw TCP routing alternative

=back

=cut
