package IO::K8s::GatewayAPI::V1::ReferenceGrant;
# ABSTRACT: Gateway API cross-namespace reference permission (v1)
our $VERSION = '1.106';
use IO::K8s::APIObject
    api_version     => 'gateway.networking.k8s.io/v1',
    resource_plural => 'referencegrants';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Represents a ReferenceGrant resource from the Kubernetes Gateway API (C<gateway.networking.k8s.io/v1>). A ReferenceGrant grants permission for resources in other namespaces to reference resources in this namespace, enabling cross-namespace resource sharing in a controlled manner. ReferenceGrant was promoted to C<gateway.networking.k8s.io/v1> in Gateway API v1.5.0, served alongside the still-storage C<gateway.networking.k8s.io/v1beta1> version; this class models the C<v1> representation. See L<IO::K8s::GatewayAPI::V1beta1::ReferenceGrant> for the C<v1beta1> storage-version class, which remains the short-name default in L<IO::K8s::GatewayAPI>'s resource map. ReferenceGrant is a namespaced resource. The C<spec> and C<status> fields are opaque hashrefs containing the Gateway API structure.

=seealso

=over

=item * L<IO::K8s::GatewayAPI> - Gateway API module namespace

=item * L<https://gateway-api.sigs.k8s.io/api-types/referencegrant/> - Upstream ReferenceGrant documentation

=item * L<IO::K8s::GatewayAPI::V1beta1::ReferenceGrant> - v1beta1 storage-version equivalent

=item * L<IO::K8s::GatewayAPI::V1::Gateway> - May use ReferenceGrant for cross-namespace references

=item * L<IO::K8s::GatewayAPI::V1::HTTPRoute> - May use ReferenceGrant for backend references

=back

=cut
