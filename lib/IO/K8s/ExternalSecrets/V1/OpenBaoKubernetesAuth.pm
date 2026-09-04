package IO::K8s::ExternalSecrets::V1::OpenBaoKubernetesAuth;
# ABSTRACT: Kubernetes authenticates with OpenBao by passing a ServiceAccount token to the [Kubernetes auth mechanism].
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s path              => Str, { required => 'schema', default => 'kubernetes' };
k8s role              => Str, { required => 'schema' };
k8s secretRef         => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';

=attr path

Path where the Kubernetes authentication backend is mounted in OpenBao, e.g:
"kubernetes"

=cut

=attr role

A required field containing the OpenBao Role to assume. A Role binds a
Kubernetes ServiceAccount with a set of OpenBao policies.

=cut

=attr secretRef

Optional secret field containing a Kubernetes ServiceAccount JWT used
for authenticating with OpenBao. If a name is specified without a key,
`token` is the default.

=cut

=attr serviceAccountRef

Optional service account field containing the name of a Kubernetes ServiceAccount.
If the service account is specified, a token will be requested from the Kubernetes
TokenRequest API for authenticating with OpenBao.
Any configured audiences will be passed to the TokenRequest as-is.

=cut

1;
