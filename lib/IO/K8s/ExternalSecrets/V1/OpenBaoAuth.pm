package IO::K8s::ExternalSecrets::V1::OpenBaoAuth;
# ABSTRACT: Auth configures how secret-manager authenticates with the OpenBao server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s appRole        => '+IO::K8s::ExternalSecrets::V1::OpenBaoAppRole';
k8s kubernetes     => '+IO::K8s::ExternalSecrets::V1::OpenBaoKubernetesAuth';
k8s namespace      => Str;
k8s tokenSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s userPass       => '+IO::K8s::ExternalSecrets::V1::OpenBaoUserPassAuth';

=attr appRole

AppRole authenticates with OpenBao using the [App Role auth mechanism],
with the role and secret stored in a Kubernetes Secret resource.

[App Role auth mechanism]: https://openbao.org/docs/auth/approle/

=cut

=attr kubernetes

Kubernetes authenticates with OpenBao by passing a ServiceAccount
token to the [Kubernetes auth mechanism].

[Kubernetes auth mechanism]: https://openbao.org/docs/auth/kubernetes/

=cut

=attr namespace

Name of the [OpenBao Namespace] to authenticate to. This can be different
than the namespace your secret is in. Namespaces is a set of features
within OpenBao that allows OpenBao environments to support secure
multi-tenancy. e.g: "ns1". This will default to OpenBao.Namespace field
if set, or empty otherwise

[OpenBao Namespace]: https://openbao.org/docs/concepts/namespaces/

=cut

=attr tokenSecretRef

TokenSecretRef authenticates with OpenBao by presenting a token.

=cut

=attr userPass

UserPass authenticates with OpenBao by passing a username/password pair

=cut

1;
