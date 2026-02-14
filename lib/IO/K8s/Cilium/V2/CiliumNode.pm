package IO::K8s::Cilium::V2::CiliumNode;
# ABSTRACT: Cilium node configuration and status
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumnodes';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource stores Cilium-specific node configuration and status, including IPAM allocations, encryption keys, and health information. It uses API version C<cilium.io/v2>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium agent running on each node.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/concepts/ipam/> - Upstream Cilium IPAM and node management documentation

=back

=cut
