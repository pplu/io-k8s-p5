package IO::K8s::Traefik::V1alpha1::TLSStore;
# ABSTRACT: Traefik TLS certificate store
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'tlsstores';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

TLSStore configures TLS certificate stores for Traefik. It manages default certificates and certificate resolution strategies. This is a namespace-scoped custom resource using API version C<traefik.io/v1alpha1>. The C<spec> and C<status> fields are opaque hashrefs managed by Traefik.

=seealso

=over

=item * L<IO::K8s::Traefik> - Traefik CRD namespace

=item * L<https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/> - Official Traefik CRD documentation

=back

=cut
