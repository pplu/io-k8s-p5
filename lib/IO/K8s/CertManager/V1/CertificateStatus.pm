package IO::K8s::CertManager::V1::CertificateStatus;
# ABSTRACT: Status of the Certificate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s acme                     => '+IO::K8s::CertManager::V1::CertificateACMEStatus';
k8s conditions               => ['Meta::V1::Condition'];
k8s failedIssuanceAttempts   => Int;
k8s lastFailureTime          => Time;
k8s nextPrivateKeySecretName => Str;
k8s notAfter                 => Time;
k8s notBefore                => Time;
k8s renewalTime              => Time;
k8s revision                 => Int;

=attr acme

ACME stores information that is fetched from the ACME CA server.

=cut

=attr conditions

List of status conditions to indicate the status of certificates.
Known condition types are `Ready` and `Issuing`.

=cut

=attr failedIssuanceAttempts

The number of continuous failed issuance attempts up till now. This
field gets removed (if set) on a successful issuance and gets set to
1 if unset and an issuance has failed. If an issuance has failed, the
delay till the next issuance will be calculated using formula
time.Hour * 2 ^ (failedIssuanceAttempts - 1).

=cut

=attr lastFailureTime

LastFailureTime is set only if the latest issuance for this
Certificate failed and contains the time of the failure. If an
issuance has failed, the delay till the next issuance will be
calculated using formula time.Hour * 2 ^ (failedIssuanceAttempts -
1). If the latest issuance has succeeded this field will be unset.

=cut

=attr nextPrivateKeySecretName

The name of the Secret resource containing the private key to be used
for the next certificate iteration.
The keymanager controller will automatically set this field if the
`Issuing` condition is set to `True`.
It will automatically unset this field when the Issuing condition is
not set or False.

=cut

=attr notAfter

The expiration time of the certificate stored in the secret named
by this resource in `spec.secretName`.

=cut

=attr notBefore

The time after which the certificate stored in the secret named
by this resource in `spec.secretName` is valid.

=cut

=attr renewalTime

RenewalTime is the time at which the certificate will be next
renewed.
If not set, no upcoming renewal is scheduled.

=cut

=attr revision

The current 'revision' of the certificate as issued.

When a CertificateRequest resource is created, it will have the
`cert-manager.io/certificate-revision` set to one greater than the
current value of this field.

Upon issuance, this field will be set to the value of the annotation
on the CertificateRequest resource used to issue the certificate.

Persisting the value on the CertificateRequest resource allows the
certificates controller to know whether a request is part of an old
issuance or if it is part of the ongoing revision's issuance by
checking if the revision value in the annotation is greater than this
field.

=cut

1;
