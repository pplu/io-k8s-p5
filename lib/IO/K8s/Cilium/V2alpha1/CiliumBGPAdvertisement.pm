package IO::K8s::Cilium::V2alpha1::CiliumBGPAdvertisement;
# ABSTRACT: Cilium BGP route advertisement
our $VERSION = '1.002';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumbgpadvertisements';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource defines which routes or IP addresses to advertise via BGP to external routers, controlling what network information Cilium shares with the broader network infrastructure. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium BGP control plane controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/bgp-control-plane/> - Upstream Cilium BGP control plane documentation

=back

=cut
