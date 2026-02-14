package IO::K8s::Cilium::V2alpha1::CiliumL2AnnouncementPolicy;
# ABSTRACT: Cilium L2 announcement policy
our $VERSION = '1.002';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliuml2announcementpolicies';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource configures L2 (ARP/NDP) announcements for service IPs, enabling direct Layer 2 reachability for Kubernetes services on local networks. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures managed by the Cilium L2 announcement controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/network/l2-announcements/> - Upstream Cilium L2 announcements documentation

=back

=cut
