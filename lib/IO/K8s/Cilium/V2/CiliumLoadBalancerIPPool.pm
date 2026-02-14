package IO::K8s::Cilium::V2::CiliumLoadBalancerIPPool;
# ABSTRACT: Cilium load balancer IP address pool
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2',
    resource_plural => 'ciliumloadbalancerippools';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource defines an IP address pool for Cilium's LB IPAM (Load Balancer IP Address Management), allowing automatic allocation of service IPs from defined ranges. It uses API version C<cilium.io/v2>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium operator.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/lb-ipam/> - Upstream Cilium LB IPAM documentation

=back

=cut
