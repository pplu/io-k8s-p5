package IO::K8s::CertManager::V1::CertificateRequest;
# ABSTRACT: cert-manager certificate signing request
our $VERSION = '1.006';
use IO::K8s::APIObject
    api_version     => 'cert-manager.io/v1',
    resource_plural => 'certificaterequests';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

CertificateRequest represents a single certificate signing request. This is a namespaced resource using the C<cert-manager.io/v1> API version. It is normally created automatically by cert-manager when processing a Certificate resource. The C<spec> and C<status> attributes contain opaque HashRefs whose structure is defined by cert-manager's OpenAPI schema.

=seealso

=over

=item * L<IO::K8s::CertManager> - cert-manager API classes for Perl

=item * L<https://cert-manager.io/docs/usage/certificaterequest/> - CertificateRequest upstream documentation

=back

=cut
