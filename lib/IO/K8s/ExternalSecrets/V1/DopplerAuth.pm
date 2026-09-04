package IO::K8s::ExternalSecrets::V1::DopplerAuth;
# ABSTRACT: Auth configures how the Operator authenticates with the Doppler API
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s oidcConfig => '+IO::K8s::ExternalSecrets::V1::DopplerOIDCAuth';
k8s secretRef  => '+IO::K8s::ExternalSecrets::V1::DopplerAuthSecretRef';

=attr oidcConfig

OIDCConfig authenticates using Kubernetes ServiceAccount tokens via OIDC.

=cut

=attr secretRef

SecretRef authenticates using a Doppler service token stored in a Kubernetes Secret.

=cut

1;
