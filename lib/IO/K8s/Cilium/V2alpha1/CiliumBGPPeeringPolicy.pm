package IO::K8s::Cilium::V2alpha1::CiliumBGPPeeringPolicy;
# ABSTRACT: Cilium BGP peering policy
our $VERSION = '1.004';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumbgppeeringpolicies';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource defines BGP peering relationships using the legacy API for advertising routes to external BGP routers. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium BGP control plane. Consider using the newer BGP configuration CRDs for new deployments.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/bgp-control-plane/> - Upstream Cilium BGP control plane documentation

=back

=cut
