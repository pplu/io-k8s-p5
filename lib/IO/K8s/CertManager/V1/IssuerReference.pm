package IO::K8s::CertManager::V1::IssuerReference;
# ABSTRACT: Reference to the issuer responsible for issuing the certificate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s group => Str;
k8s kind  => Str;
k8s name  => Str, { required => 'schema' };

=attr group

Group of the issuer being referred to.
Defaults to 'cert-manager.io'.

=cut

=attr kind

Kind of the issuer being referred to.
Defaults to 'Issuer'.

=cut

=attr name

Name of the issuer being referred to.

=cut

1;
