package IO::K8s::ExternalSecrets::V1alpha1::GithubAccessToken;
# ABSTRACT: GithubAccessToken generates ghs_ accessToken
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'githubaccesstokens';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::GithubAccessTokenSpec';

=attr spec

GithubAccessTokenSpec defines the desired state to generate a GitHub access token.

=cut

1;
