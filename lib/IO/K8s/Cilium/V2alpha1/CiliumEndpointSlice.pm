package IO::K8s::Cilium::V2alpha1::CiliumEndpointSlice;
# ABSTRACT: Cilium endpoint slice for scalable endpoint tracking
our $VERSION = '1.003';
use IO::K8s::APIObject
    api_version     => 'cilium.io/v2alpha1',
    resource_plural => 'ciliumendpointslices';

k8s endpoints => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

This cluster-scoped resource aggregates multiple CiliumEndpoints for improved scalability in large clusters, reducing the number of individual endpoint objects the API server must handle. It uses API version C<cilium.io/v2alpha1>. The C<endpoints> field contains opaque CRD-specific data structures managed by the Cilium operator.

=seealso

=over

=item * L<IO::K8s::Cilium> - Main Cilium CRD namespace

=item * L<https://docs.cilium.io/en/stable/internals/cilium-operator/> - Upstream Cilium operator and endpoint slice documentation

=back

=cut
