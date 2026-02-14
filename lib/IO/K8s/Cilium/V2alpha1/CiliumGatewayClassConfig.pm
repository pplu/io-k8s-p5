package IO::K8s::Cilium::V2alpha1::CiliumGatewayClassConfig;
# ABSTRACT: Cilium Gateway API class configuration
our $VERSION = '1.002';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumgatewayclassconfigs';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource provides configuration for the Cilium Gateway API controller, defining how Cilium implements Kubernetes Gateway API resources for ingress traffic management. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium Gateway API controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/servicemesh/gateway-api/> - Upstream Cilium Gateway API documentation

=back

=cut
