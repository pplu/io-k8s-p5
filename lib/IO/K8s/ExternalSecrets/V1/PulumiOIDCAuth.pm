package IO::K8s::ExternalSecrets::V1::PulumiOIDCAuth;
# ABSTRACT: OIDCConfig authenticates using Kubernetes ServiceAccount tokens via OIDC.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s expirationSeconds => Int, { minimum => 600, default => 600 };
k8s organization      => Str, { required => 'schema' };
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector', { required => 'schema' };

=attr expirationSeconds

ExpirationSeconds sets the token validity duration for service account and OIDC token.
Defaults to 10 minutes.

=cut

=attr organization

Organization is the name of the Pulumi organization configured for OIDC authentication.

=cut

=attr serviceAccountRef

ServiceAccountRef specifies the Kubernetes ServiceAccount to use for authentication.

=cut

1;
