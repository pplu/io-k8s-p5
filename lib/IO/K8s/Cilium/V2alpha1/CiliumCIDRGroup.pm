package IO::K8s::Cilium::V2alpha1::CiliumCIDRGroup;
# ABSTRACT: Cilium CIDR group for IP address management
our $VERSION = '1.005';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumcidrgroups';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource defines reusable sets of CIDRs that can be referenced in network policies, simplifying policy management for groups of IP ranges. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium policy controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/kubernetes/policy/> - Upstream Cilium network policy documentation

=back

=cut
