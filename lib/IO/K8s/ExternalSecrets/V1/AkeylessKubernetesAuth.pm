package IO::K8s::ExternalSecrets::V1::AkeylessKubernetesAuth;
# ABSTRACT: Kubernetes authenticates with Akeyless by passing the ServiceAccount token stored in the named Secret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessID          => Str, { required => 'schema' };
k8s k8sConfName       => Str, { required => 'schema' };
k8s secretRef         => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';

=attr accessID

the Akeyless Kubernetes auth-method access-id

=cut

=attr k8sConfName

Kubernetes-auth configuration name in Akeyless-Gateway

=cut

=attr secretRef

Optional secret field containing a Kubernetes ServiceAccount JWT used
for authenticating with Akeyless. If a name is specified without a key,
`token` is the default. If one is not specified, the one bound to
the controller will be used.

=cut

=attr serviceAccountRef

Optional service account field containing the name of a kubernetes ServiceAccount.
If the service account is specified, the service account secret token JWT will be used
for authenticating with Akeyless. If the service account selector is not supplied,
the secretRef will be used instead.

=cut

1;
