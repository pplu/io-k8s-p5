package IO::K8s::Cilium::V2::CiliumLocalRedirectPolicy;
# ABSTRACT: Cilium local redirect policy for traffic steering
our $VERSION = '1.003';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumlocalredirectpolicies';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This namespace-scoped resource redirects traffic destined for a service to local endpoints on the same node, reducing network hops and latency. It uses API version C<cilium.io/v2>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/kubernetes/local-redirect-policy/> - Upstream Cilium local redirect policy documentation

=back

=cut
