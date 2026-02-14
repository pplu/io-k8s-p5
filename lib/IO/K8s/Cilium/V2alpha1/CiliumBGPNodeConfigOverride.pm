package IO::K8s::Cilium::V2alpha1::CiliumBGPNodeConfigOverride;
# ABSTRACT: Cilium BGP per-node configuration override
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumbgpnodeconfigoverrides';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource provides per-node BGP configuration overrides that take precedence over cluster-level BGP settings, enabling fine-grained node-specific BGP behavior. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium BGP control plane controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/bgp-control-plane/> - Upstream Cilium BGP control plane documentation

=back

=cut
