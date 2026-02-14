package IO::K8s::Cilium::V2::CiliumEndpoint;
# ABSTRACT: Cilium endpoint representing a pod's network state
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumendpoints';
with 'IO::K8s::Role::Namespaced';

k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This namespace-scoped resource represents a Cilium-managed endpoint, typically a Pod's network interface. It tracks the endpoint's networking state, security identity, and policy enforcement status, using API version C<cilium.io/v2>. The C<status> field contains opaque CRD-specific data structures managed by the Cilium agent.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/internals/cilium-operator/> - Upstream Cilium operator and endpoint management documentation

=back

=cut
