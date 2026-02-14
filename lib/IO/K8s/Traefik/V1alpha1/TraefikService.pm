package IO::K8s::Traefik::V1alpha1::TraefikService;
# ABSTRACT: Traefik weighted round-robin and mirroring service
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'traefikservices';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::Loadbalanced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

TraefikService defines advanced load balancing and traffic routing. It enables weighted round-robin distribution across multiple services and traffic mirroring for A/B testing. This is a namespace-scoped custom resource using API version C<traefik.io/v1alpha1>. The C<spec> and C<status> fields are opaque hashrefs managed by Traefik.

=seealso

=over

=item * L<IO::K8s::Traefik> - Traefik CRD namespace

=item * L<https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/> - Official Traefik CRD documentation

=back

=cut
