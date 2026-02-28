package IO::K8s::Cilium::V2alpha1::CiliumBGPPeerConfig;
# ABSTRACT: Cilium BGP peer configuration
our $VERSION = '1.006';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumbgppeerconfigs';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource configures individual BGP peer parameters, including neighbor addresses, authentication, and session options for Cilium's BGP control plane. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium BGP control plane controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/bgp-control-plane/> - Upstream Cilium BGP control plane documentation

=back

=cut
