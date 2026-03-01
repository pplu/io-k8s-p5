package IO::K8s::CertManager::V1::Challenge;
# ABSTRACT: cert-manager ACME challenge
our $VERSION = '1.007';
use IO::K8s::APIObject
    api_version     => 'acme.cert-manager.io/v1',
    resource_plural => 'challenges';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Challenge represents a single ACME challenge (HTTP-01 or DNS-01) that must be completed to prove domain ownership. This is a namespaced resource using the C<acme.cert-manager.io/v1> API version. It is created automatically as part of the ACME order fulfillment process. The C<spec> and C<status> attributes contain opaque HashRefs whose structure is defined by cert-manager's OpenAPI schema.

=seealso

=over

=item * L<IO::K8s::CertManager> - cert-manager API classes for Perl

=item * L<https://cert-manager.io/docs/reference/api-docs/#acme.cert-manager.io/v1.Challenge> - Challenge upstream documentation

=back

=cut
