package IO::K8s::CertManager::V1::ClusterIssuer;
# ABSTRACT: cert-manager cluster-scoped certificate issuer
our $VERSION = '1.004';
use IO::K8s::APIObject
    api_version     => 'cert-manager.io/v1',
    resource_plural => 'clusterissuers';

with 'IO::K8s::Role::CertManaged';

k8s spec   => { Str => 1 };
k8s status => { Str => 1 };

1;

__END__

=head1 DESCRIPTION

ClusterIssuer configures a cluster-wide certificate issuer, available to Certificate resources in any namespace. This is a cluster-scoped resource using the C<cert-manager.io/v1> API version. It functions similarly to Issuer but is not limited to a single namespace. The C<spec> and C<status> attributes contain opaque HashRefs whose structure is defined by cert-manager's OpenAPI schema.

=seealso

=over

=item * L<IO::K8s::CertManager> - cert-manager API classes for Perl

=item * L<https://cert-manager.io/docs/configuration/> - ClusterIssuer upstream documentation

=back

=cut
