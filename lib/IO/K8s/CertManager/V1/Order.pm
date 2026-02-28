package IO::K8s::CertManager::V1::Order;
# ABSTRACT: cert-manager ACME order
our $VERSION = '1.006';
use IO::K8s::APIObject
    api_version     => 'acme.cert-manager.io/v1',
    resource_plural => 'orders';
with 'IO::K8s::Role::Namespaced';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

Order represents an ACME order for a certificate. This is a namespaced resource using the C<acme.cert-manager.io/v1> API version. It is created automatically when using an ACME issuer and tracks the overall certificate request process. The C<spec> and C<status> attributes contain opaque HashRefs whose structure is defined by cert-manager's OpenAPI schema.

=seealso

=over

=item * L<IO::K8s::CertManager> - cert-manager API classes for Perl

=item * L<https://cert-manager.io/docs/reference/api-docs/#acme.cert-manager.io/v1.Order> - Order upstream documentation

=back

=cut
