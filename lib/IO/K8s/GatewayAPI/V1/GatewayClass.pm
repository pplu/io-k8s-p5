package IO::K8s::GatewayAPI::V1::GatewayClass;
# ABSTRACT: Gateway API controller class definition
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'gatewayclasses';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents a GatewayClass resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). A GatewayClass defines a class of Gateways, identifying the controller implementation that will manage Gateways of this class. This is similar to IngressClass for Ingress resources. GatewayClass is a cluster-scoped resource. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/gatewayclass/> - Upstream GatewayClass documentation

=item * L<IO::K8s::GatewayAPI::V1::Gateway> - Gateway instances that reference this class

=back

=cut
