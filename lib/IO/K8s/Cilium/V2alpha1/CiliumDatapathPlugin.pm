package IO::K8s::Cilium::V2alpha1::CiliumDatapathPlugin;
# ABSTRACT: Cilium extensible datapath plugin registration
our $VERSION = '1.107';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumdatapathplugins';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource registers a Cilium extensible datapath plugin, letting cloud providers extend or instrument Cilium's eBPF datapath. It uses API version C<cilium.io/v2alpha1>. The C<spec> and C<status> fields contain opaque CRD-specific data structures; upstream C<spec> carries C<attachmentPolicy> (C<Always> or C<BestEffort>) and C<version>, both managed by the Cilium datapath plugin controller.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/> - Upstream Cilium documentation

=back

=cut
