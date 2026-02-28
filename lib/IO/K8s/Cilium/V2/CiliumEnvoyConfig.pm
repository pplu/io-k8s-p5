package IO::K8s::Cilium::V2::CiliumEnvoyConfig;
# ABSTRACT: Cilium Envoy proxy configuration
our $VERSION = '1.004';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumenvoyconfigs';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This namespace-scoped resource configures an Envoy proxy sidecar for L7 network policies and service mesh capabilities within a namespace. It uses API version C<cilium.io/v2>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium operator and Envoy integration.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/servicemesh/envoy-config/> - Upstream Cilium Envoy configuration documentation

=back

=cut
