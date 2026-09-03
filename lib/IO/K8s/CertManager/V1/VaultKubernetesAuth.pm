package IO::K8s::CertManager::V1::VaultKubernetesAuth;
# ABSTRACT: Kubernetes authenticates with Vault by passing the ServiceAccount token stored in the named Secret resource to the Vault server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mountPath         => Str;
k8s role              => Str, { required => 'schema' };
k8s secretRef         => '+IO::K8s::CertManager::V1::SecretKeySelector';
k8s serviceAccountRef => '+IO::K8s::CertManager::V1::ServiceAccountRef';

=attr mountPath

The Vault mountPath here is the mount path to use when authenticating with
Vault. For example, setting a value to `/v1/auth/foo`, will use the path
`/v1/auth/foo/login` to authenticate with Vault. If unspecified, the
default value "/v1/auth/kubernetes" will be used.

=cut

=attr role

A required field containing the Vault Role to assume. A Role binds a
Kubernetes ServiceAccount with a set of Vault policies.

=cut

=attr secretRef

The required Secret field containing a Kubernetes ServiceAccount JWT used
for authenticating with Vault. Use of 'ambient credentials' is not
supported.

=cut

=attr serviceAccountRef

A reference to a service account that will be used to request a bound
token (also known as "projected token"). Compared to using "secretRef",
using this field means that you don't rely on statically bound tokens. To
use this field, you must configure an RBAC rule to let cert-manager
request a token.

=cut

1;
