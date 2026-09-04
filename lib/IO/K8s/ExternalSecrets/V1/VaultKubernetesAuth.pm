package IO::K8s::ExternalSecrets::V1::VaultKubernetesAuth;
# ABSTRACT: Kubernetes authenticates with Vault by passing the ServiceAccount token stored in the named Secret resource to the Vault server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s mountPath         => Str, { required => 'schema', default => 'kubernetes' };
k8s role              => Str, { required => 'schema' };
k8s secretRef         => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';

=attr mountPath

Path where the Kubernetes authentication backend is mounted in Vault, e.g:
"kubernetes"

=cut

=attr role

A required field containing the Vault Role to assume. A Role binds a
Kubernetes ServiceAccount with a set of Vault policies.

=cut

=attr secretRef

Optional secret field containing a Kubernetes ServiceAccount JWT used
for authenticating with Vault. If a name is specified without a key,
`token` is the default. If one is not specified, the one bound to
the controller will be used.

=cut

=attr serviceAccountRef

Optional service account field containing the name of a kubernetes ServiceAccount.
If the service account is specified, the service account secret token JWT will be used
for authenticating with Vault. If the service account selector is not supplied,
the secretRef will be used instead.

=cut

1;
