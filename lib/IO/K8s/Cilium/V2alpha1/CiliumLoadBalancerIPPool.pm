package IO::K8s::Cilium::V2alpha1::CiliumLoadBalancerIPPool;
# ABSTRACT: Cilium load balancer IP address pool (cilium.io/v2alpha1 back-compat)
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumloadbalancerippools';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource defines an IP address pool for Cilium's LB IPAM (Load Balancer IP Address Management), allowing automatic allocation of service IPs from defined ranges. It uses API version C<cilium.io/v2alpha1>, the back-compat track for clusters still on older Cilium releases; newer releases serve the same Kind at C<cilium.io/v2> (see L<IO::K8s::Cilium::V2::CiliumLoadBalancerIPPool>). The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium operator.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<IO::K8s::Cilium::V2::CiliumLoadBalancerIPPool> - The C<cilium.io/v2> storage version

=item * L<https://docs.cilium.io/en/stable/network/lb-ipam/> - Upstream Cilium LB IPAM documentation

=back

=cut
