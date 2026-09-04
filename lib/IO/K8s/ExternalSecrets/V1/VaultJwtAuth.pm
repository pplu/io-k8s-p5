package IO::K8s::ExternalSecrets::V1::VaultJwtAuth;
# ABSTRACT: Jwt authenticates with Vault by passing role and JWT token using the JWT/OIDC authentication method
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kubernetesServiceAccountToken => '+IO::K8s::ExternalSecrets::V1::VaultKubernetesServiceAccountTokenAuth';
k8s path                          => Str, { required => 'schema', default => 'jwt' };
k8s role                          => Str;
k8s secretRef                     => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr kubernetesServiceAccountToken

Optional ServiceAccountToken specifies the Kubernetes service account for which to request
a token for with the `TokenRequest` API.

=cut

=attr path

Path where the JWT authentication backend is mounted
in Vault, e.g: "jwt"

=cut

=attr role

Role is a JWT role to authenticate using the JWT/OIDC Vault
authentication method

=cut

=attr secretRef

Optional SecretRef that refers to a key in a Secret resource containing JWT token to
authenticate with Vault using the JWT/OIDC authentication method.

=cut

1;
