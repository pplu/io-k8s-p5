package IO::K8s::Traefik::V1alpha1::IngressRouteTCP;
# ABSTRACT: Traefik TCP routing via IngressRouteTCP
our $VERSION = '1.004';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'ingressroutetcps';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

IngressRouteTCP defines TCP routing rules for Traefik. It configures routes, match rules, and services for raw TCP traffic. This is a namespace-scoped custom resource using API version C<traefik.io/v1alpha1>. The C<spec> and C<status> fields are opaque hashrefs managed by Traefik.

=seealso

=over

=item * L<IO::K8s::Traefik> - Traefik CRD namespace

=item * L<https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/> - Official Traefik CRD documentation

=back

=cut
