package IO::K8s::ExternalSecrets::V1::VaultAuth;
# ABSTRACT: Auth configures how secret-manager authenticates with the Vault server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s appRole        => '+IO::K8s::ExternalSecrets::V1::VaultAppRole';
k8s cert           => '+IO::K8s::ExternalSecrets::V1::VaultCertAuth';
k8s gcp            => '+IO::K8s::ExternalSecrets::V1::VaultGCPAuth';
k8s iam            => '+IO::K8s::ExternalSecrets::V1::VaultIamAuth';
k8s jwt            => '+IO::K8s::ExternalSecrets::V1::VaultJwtAuth';
k8s kubernetes     => '+IO::K8s::ExternalSecrets::V1::VaultKubernetesAuth';
k8s ldap           => '+IO::K8s::ExternalSecrets::V1::VaultLdapAuth';
k8s namespace      => Str;
k8s tokenSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s userPass       => '+IO::K8s::ExternalSecrets::V1::VaultUserPassAuth';

=attr appRole

AppRole authenticates with Vault using the App Role auth mechanism,
with the role and secret stored in a Kubernetes Secret resource.

=cut

=attr cert

Cert authenticates with TLS Certificates by passing client certificate, private key and ca certificate
Cert authentication method

=cut

=attr gcp

Gcp authenticates with Vault using Google Cloud Platform authentication method
GCP authentication method

=cut

=attr iam

Iam authenticates with vault by passing a special AWS request signed with AWS IAM credentials
AWS IAM authentication method

=cut

=attr jwt

Jwt authenticates with Vault by passing role and JWT token using the
JWT/OIDC authentication method

=cut

=attr kubernetes

Kubernetes authenticates with Vault by passing the ServiceAccount
token stored in the named Secret resource to the Vault server.

=cut

=attr ldap

Ldap authenticates with Vault by passing username/password pair using
the LDAP authentication method

=cut

=attr namespace

Name of the vault namespace to authenticate to. This can be different than the namespace your secret is in.
Namespaces is a set of features within Vault Enterprise that allows
Vault environments to support Secure Multi-tenancy. e.g: "ns1".
More about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces
This will default to Vault.Namespace field if set, or empty otherwise

=cut

=attr tokenSecretRef

TokenSecretRef authenticates with Vault by presenting a token.

=cut

=attr userPass

UserPass authenticates with Vault by passing username/password pair

=cut

1;
