package IO::K8s::ExternalSecrets::V1alpha1::ACRAccessToken;
# ABSTRACT: ACRAccessToken returns an Azure Container Registry token that can be used for pushing/pulling images.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'acraccesstokens';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::ACRAccessTokenSpec';

=attr spec

ACRAccessTokenSpec defines how to generate the access token
e.g. how to authenticate and which registry to use.
see: https://github.com/Azure/acr/blob/main/docs/AAD-OAuth.md#overview

=cut

1;
