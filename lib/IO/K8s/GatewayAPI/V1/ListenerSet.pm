package IO::K8s::GatewayAPI::V1::ListenerSet;
# ABSTRACT: Gateway API listeners defined independently of a Gateway
our $VERSION = '1.101';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'listenersets';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents a ListenerSet resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). A ListenerSet defines a set of listeners independently of a Gateway and merges them onto a parent Gateway via C<parentRef>, enabling multi-tenant listener delegation and Gateways with more than 64 listeners. ListenerSet is a namespaced resource. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/listenerset/> - Upstream ListenerSet documentation

=item * L<IO::K8s::GatewayAPI::V1::Gateway> - Parent Gateway these listeners merge onto

=back

=cut
