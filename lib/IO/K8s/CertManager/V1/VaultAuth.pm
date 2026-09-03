package IO::K8s::CertManager::V1::VaultAuth;
# ABSTRACT: Auth configures how cert-manager authenticates with the Vault server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s appRole           => '+IO::K8s::CertManager::V1::VaultAppRole';
k8s aws               => '+IO::K8s::CertManager::V1::VaultAWSAuth';
k8s clientCertificate => '+IO::K8s::CertManager::V1::VaultClientCertificateAuth';
k8s kubernetes        => '+IO::K8s::CertManager::V1::VaultKubernetesAuth';
k8s tokenSecretRef    => '+IO::K8s::CertManager::V1::SecretKeySelector';

=attr appRole

AppRole authenticates with Vault using the App Role auth mechanism,
with the role and secret stored in a Kubernetes Secret resource.

=cut

=attr aws

AWS authenticates with Vault using AWS IAM authentication.
This allows authentication using IAM roles for service accounts (IRSA),
EKS Pod Identity (PIA), or ambient credentials (EC2 instance profiles, ECS task role).

=cut

=attr clientCertificate

ClientCertificate authenticates with Vault by presenting a client
certificate during the request's TLS handshake.
Works only when using HTTPS protocol.

=cut

=attr kubernetes

Kubernetes authenticates with Vault by passing the ServiceAccount
token stored in the named Secret resource to the Vault server.

=cut

=attr tokenSecretRef

TokenSecretRef authenticates with Vault by presenting a token.

=cut

1;
