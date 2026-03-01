package IO::K8s::Cilium::V2::CiliumClusterwideNetworkPolicy;
# ABSTRACT: Cilium cluster-wide network policy
our $VERSION = '1.007';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumclusterwidenetworkpolicies';

with 'IO::K8s::Role::NetworkPolicy';

sub _netpol_format { 'cilium' }

k8s spec   => { Str => 1 };
k8s specs  => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This resource represents a cluster-wide network policy applied across all namespaces in the Kubernetes cluster. It uses API version C<cilium.io/v2> and provides global network security enforcement via Cilium's eBPF datapath. The C<spec>, C<specs>, and C<status> fields contain opaque CRD-specific data structures managed by the Cilium controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/kubernetes/policy/> - Upstream Cilium network policy documentation

=back

=cut
