package IO::K8s::Traefik::V1alpha1::IngressRouteUDP;
# ABSTRACT: Traefik UDP routing via IngressRouteUDP
our $VERSION = '1.005';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'ingressrouteudps';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

IngressRouteUDP defines UDP routing rules for Traefik. It configures routes and services for UDP traffic such as DNS or game servers. This is a namespace-scoped custom resource using API version C<traefik.io/v1alpha1>. The C<spec> and C<status> fields are opaque hashrefs managed by Traefik.

=seealso

=over

=item * L<IO::K8s::Traefik> - Traefik CRD namespace

=item * L<https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/> - Official Traefik CRD documentation

=back

=cut
