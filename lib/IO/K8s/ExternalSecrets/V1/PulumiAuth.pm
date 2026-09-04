package IO::K8s::ExternalSecrets::V1::PulumiAuth;
# ABSTRACT: Auth configures how the Operator authenticates with the Pulumi API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessToken => '+IO::K8s::ExternalSecrets::V1::PulumiProviderSecretRef';
k8s oidcConfig  => '+IO::K8s::ExternalSecrets::V1::PulumiOIDCAuth';

=attr accessToken

AccessToken authenticates using a Pulumi access token stored in a Kubernetes Secret.

=cut

=attr oidcConfig

OIDCConfig authenticates using Kubernetes ServiceAccount tokens via OIDC.

=cut

1;
