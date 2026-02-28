package IO::K8s::Cilium::V2::CiliumNetworkPolicy;
# ABSTRACT: Cilium network policy for namespace-scoped network security
our $VERSION = '1.006';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumnetworkpolicies';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::NetworkPolicy';

sub _netpol_format { 'cilium' }

k8s spec   => { Str => 1 };
k8s specs  => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This resource represents a namespace-scoped network policy enforced by Cilium's eBPF datapath. It provides fine-grained network security rules for pods within a namespace, using API version C<cilium.io/v2>. The C<spec>, C<specs>, and C<status> fields contain opaque CRD-specific data structures managed by the Cilium controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/kubernetes/policy/> - Upstream Cilium network policy documentation

=back

=cut
