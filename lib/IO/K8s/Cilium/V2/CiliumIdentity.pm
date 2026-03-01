package IO::K8s::Cilium::V2::CiliumIdentity;
# ABSTRACT: Cilium security identity
our $VERSION = '1.007';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumidentities';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource represents a Cilium security identity assigned to a set of endpoints based on their labels. Security identities are used by Cilium's eBPF datapath for efficient policy enforcement, using API version C<cilium.io/v2>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/internals/security-identities/> - Upstream Cilium security identities documentation

=back

=cut
