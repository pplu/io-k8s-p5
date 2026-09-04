package IO::K8s::ExternalSecrets::V1::VaultKubernetesServiceAccountTokenAuth;
# ABSTRACT: Optional ServiceAccountToken specifies the Kubernetes service account for which to request a token for with the `TokenRequest` API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s audiences         => [Str];
k8s expirationSeconds => Int;
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector', { required => 'schema' };

=attr audiences

Optional audiences field that will be used to request a temporary Kubernetes service
account token for the service account referenced by `serviceAccountRef`.
Defaults to a single audience `vault` it not specified.

Deprecated: use serviceAccountRef.Audiences instead

=cut

=attr expirationSeconds

Optional expiration time in seconds that will be used to request a temporary
Kubernetes service account token for the service account referenced by
`serviceAccountRef`.

Deprecated: this will be removed in the future.
Defaults to 10 minutes.

=cut

=attr serviceAccountRef

Service account field containing the name of a kubernetes ServiceAccount.

=cut

1;
