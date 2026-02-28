package IO::K8s::Traefik::V1alpha1::ServersTransport;
# ABSTRACT: Traefik servers transport configuration
our $VERSION = '1.006';
use IO::K8s::APIObject
    api_version     => 'traefik.io/v1alpha1',
    resource_plural => 'serverstransports';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

ServersTransport configures transport settings for connections to backend HTTP servers. It controls TLS verification, timeouts, and connection pooling for upstream services. This is a namespace-scoped custom resource using API version C<traefik.io/v1alpha1>. The C<spec> and C<status> fields are opaque hashrefs managed by Traefik.

=seealso

=over

=item * L<IO::K8s::Traefik> - Traefik CRD namespace

=item * L<https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/> - Official Traefik CRD documentation

=back

=cut
