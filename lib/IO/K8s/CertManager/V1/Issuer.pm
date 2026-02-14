package IO::K8s::CertManager::V1::Issuer;
# ABSTRACT: cert-manager namespace-scoped certificate issuer
our $VERSION = '1.001';
use IO::K8s::APIObject
    api_version     => 'cert-manager.io/v1',
    resource_plural => 'issuers';
with 'IO::K8s::Role::Namespaced', 'IO::K8s::Role::CertManaged';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Issuer configures a namespace-scoped certificate issuer (e.g. ACME, CA, Vault). This is a namespaced resource using the C<cert-manager.io/v1> API version. It can only be referenced by Certificate resources in the same namespace. The C<spec> and C<status> attributes contain opaque HashRefs whose structure is defined by cert-manager's OpenAPI schema.

=seealso

=over

=item * L<IO::K8s::CertManager> - cert-manager API classes for Perl

=item * L<https://cert-manager.io/docs/configuration/> - Issuer upstream documentation

=back

=cut
