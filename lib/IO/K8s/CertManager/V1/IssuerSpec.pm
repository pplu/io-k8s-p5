package IO::K8s::CertManager::V1::IssuerSpec;
# ABSTRACT: Desired state of the Issuer resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s acme       => '+IO::K8s::CertManager::V1::ACMEIssuer';
k8s ca         => '+IO::K8s::CertManager::V1::CAIssuer';
k8s selfSigned => '+IO::K8s::CertManager::V1::SelfSignedIssuer';
k8s vault      => '+IO::K8s::CertManager::V1::VaultIssuer';
k8s venafi     => '+IO::K8s::CertManager::V1::VenafiIssuer';

=attr acme

ACME configures this issuer to communicate with a RFC8555 (ACME) server
to obtain signed x509 certificates.

=cut

=attr ca

CA configures this issuer to sign certificates using a signing CA keypair
stored in a Secret resource.
This is used to build internal PKIs that are managed by cert-manager.

=cut

=attr selfSigned

SelfSigned configures this issuer to 'self sign' certificates using the
private key used to create the CertificateRequest object.

=cut

=attr vault

Vault configures this issuer to sign certificates using a HashiCorp Vault
PKI backend.

=cut

=attr venafi

Venafi configures this issuer to sign certificates using a CyberArk Certificate Manager Self-Hosted
or SaaS policy zone.

=cut

1;
