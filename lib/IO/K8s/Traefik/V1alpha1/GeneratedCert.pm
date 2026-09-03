package IO::K8s::Traefik::V1alpha1::GeneratedCert;
# ABSTRACT: DefaultGeneratedCert defines the default generated certificate configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s domain   => '+IO::K8s::Traefik::V1alpha1::Domain';
k8s resolver => Str;

=attr domain

Domain is the domain definition for the DefaultCertificate.

=cut

=attr resolver

Resolver is the name of the resolver that will be used to issue the DefaultCertificate.

=cut

1;
