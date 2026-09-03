package IO::K8s::CertManager::V1::IssuerStatus;
# ABSTRACT: Status of the Issuer.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s acme       => '+IO::K8s::CertManager::V1::ACMEIssuerStatus';
k8s conditions => ['Meta::V1::Condition'];

=attr acme

ACME specific status options.
This field should only be set if the Issuer is configured to use an ACME
server to issue certificates.

=cut

=attr conditions

List of status conditions to indicate the status of a CertificateRequest.
Known condition types are `Ready`.

=cut

1;
