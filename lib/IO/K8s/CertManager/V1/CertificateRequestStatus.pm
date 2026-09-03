package IO::K8s::CertManager::V1::CertificateRequestStatus;
# ABSTRACT: Status of the CertificateRequest.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ca          => Str;
k8s certificate => Str;
k8s conditions  => ['Core::V1::NamespaceCondition'];
k8s failureTime => Time;

=attr ca

The PEM encoded X.509 certificate of the signer, also known as the CA
(Certificate Authority).
This is set on a best-effort basis by different issuers.
If not set, the CA is assumed to be unknown/not available.

=cut

=attr certificate

The PEM encoded X.509 certificate resulting from the certificate
signing request.
If not set, the CertificateRequest has either not been completed or has
failed. More information on failure can be found by checking the
`conditions` field.

=cut

=attr conditions

List of status conditions to indicate the status of a CertificateRequest.
Known condition types are `Ready`, `InvalidRequest`, `Approved` and `Denied`.

=cut

=attr failureTime

FailureTime stores the time that this CertificateRequest failed. This is
used to influence garbage collection and back-off.

=cut

1;
