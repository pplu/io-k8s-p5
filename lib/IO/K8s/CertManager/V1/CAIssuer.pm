package IO::K8s::CertManager::V1::CAIssuer;
# ABSTRACT: CA configures this issuer to sign certificates using a signing CA keypair stored in a Secret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s crlDistributionPoints  => [Str];
k8s issuingCertificateURLs => [Str];
k8s ocspServers            => [Str];
k8s secretName             => Str, { required => 'schema' };

=attr crlDistributionPoints

The CRL distribution points is an X.509 v3 certificate extension which identifies
the location of the CRL from which the revocation of this certificate can be checked.
If not set, certificates will be issued without distribution points set.

=cut

=attr issuingCertificateURLs

IssuingCertificateURLs is a list of URLs which this issuer should embed into certificates
it creates. See https://www.rfc-editor.org/rfc/rfc5280#section-4.2.2.1 for more details.
As an example, such a URL might be "http://ca.domain.com/ca.crt".

=cut

=attr ocspServers

The OCSP server list is an X.509 v3 extension that defines a list of
URLs of OCSP responders. The OCSP responders can be queried for the
revocation status of an issued certificate. If not set, the
certificate will be issued with no OCSP servers set. For example, an
OCSP server URL could be "http://ocsp.int-x3.letsencrypt.org".

=cut

=attr secretName

SecretName is the name of the secret used to sign Certificates issued
by this Issuer.

=cut

1;
