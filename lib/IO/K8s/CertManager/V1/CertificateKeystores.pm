package IO::K8s::CertManager::V1::CertificateKeystores;
# ABSTRACT: Additional keystore output formats to be stored in the Certificate's Secret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s jks    => '+IO::K8s::CertManager::V1::JKSKeystore';
k8s pkcs12 => '+IO::K8s::CertManager::V1::PKCS12Keystore';

=attr jks

JKS configures options for storing a JKS keystore in the
`spec.secretName` Secret resource.

=cut

=attr pkcs12

PKCS12 configures options for storing a PKCS12 keystore in the
`spec.secretName` Secret resource.

=cut

1;
