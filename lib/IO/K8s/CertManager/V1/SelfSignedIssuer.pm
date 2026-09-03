package IO::K8s::CertManager::V1::SelfSignedIssuer;
# ABSTRACT: SelfSigned configures this issuer to 'self sign' certificates using the private key used to create the CertificateRequest object.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s crlDistributionPoints => [Str];

=attr crlDistributionPoints

The CRL distribution points is an X.509 v3 certificate extension which identifies
the location of the CRL from which the revocation of this certificate can be checked.
If not set certificate will be issued without CDP. Values are strings.

=cut

1;
