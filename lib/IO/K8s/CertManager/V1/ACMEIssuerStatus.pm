package IO::K8s::CertManager::V1::ACMEIssuerStatus;
# ABSTRACT: ACME specific status options.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s lastPrivateKeyHash  => Str;
k8s lastRegisteredEmail => Str;
k8s uri                 => Str;

=attr lastPrivateKeyHash

LastPrivateKeyHash is a hash of the private key associated with the latest
registered ACME account, in order to track changes made to registered account
associated with the Issuer

=cut

=attr lastRegisteredEmail

LastRegisteredEmail is the email associated with the latest registered
ACME account, in order to track changes made to registered account
associated with the  Issuer

=cut

=attr uri

URI is the unique account identifier, which can also be used to retrieve
account details from the CA

=cut

1;
