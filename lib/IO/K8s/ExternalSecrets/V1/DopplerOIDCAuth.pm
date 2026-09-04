package IO::K8s::ExternalSecrets::V1::DopplerOIDCAuth;
# ABSTRACT: OIDCConfig authenticates using Kubernetes ServiceAccount tokens via OIDC.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s expirationSeconds => Int, { default => 600 };
k8s identity          => Str, { required => 'schema' };
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector', { required => 'schema' };

=attr expirationSeconds

ExpirationSeconds sets the ServiceAccount token validity duration.
Defaults to 10 minutes.

=cut

=attr identity

Identity is the Doppler Service Account Identity ID configured for OIDC authentication.

=cut

=attr serviceAccountRef

ServiceAccountRef specifies the Kubernetes ServiceAccount to use for authentication.

=cut

1;
