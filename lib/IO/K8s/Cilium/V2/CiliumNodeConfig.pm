package IO::K8s::Cilium::V2::CiliumNodeConfig;
# ABSTRACT: Cilium per-node configuration overrides
our $VERSION = '1.003';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumnodeconfigs';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This namespace-scoped resource provides per-node Cilium agent configuration overrides, allowing node-specific customization of Cilium behavior. It uses API version C<cilium.io/v2>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium operator.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/node-specific/> - Upstream Cilium node-specific configuration documentation

=back

=cut
