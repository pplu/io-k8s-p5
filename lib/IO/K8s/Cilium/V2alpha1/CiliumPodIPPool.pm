package IO::K8s::Cilium::V2alpha1::CiliumPodIPPool;
# ABSTRACT: Cilium pod IP address pool
our $VERSION = '1.007';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumpodippools';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource defines IP pools for multi-pool IPAM, allowing different pod groups to receive IPs from designated ranges based on namespace or pod labels. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium IPAM controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/concepts/ipam/multi-pool/> - Upstream Cilium multi-pool IPAM documentation

=back

=cut
