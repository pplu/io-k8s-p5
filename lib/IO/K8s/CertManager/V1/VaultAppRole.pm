package IO::K8s::CertManager::V1::VaultAppRole;
# ABSTRACT: AppRole authenticates with Vault using the App Role auth mechanism, with the role and secret stored in a Kubernetes Secret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s path      => Str, { required => 'schema' };
k8s roleId    => Str, { required => 'schema' };
k8s secretRef => '+IO::K8s::CertManager::V1::SecretKeySelector', { required => 'schema' };

=attr path

Path where the App Role authentication backend is mounted in Vault, e.g:
"approle"

=cut

=attr roleId

RoleID configured in the App Role authentication backend when setting
up the authentication backend in Vault.

=cut

=attr secretRef

Reference to a key in a Secret that contains the App Role secret used
to authenticate with Vault.
The `key` field must be specified and denotes which entry within the Secret
resource is used as the app role secret.

=cut

1;
