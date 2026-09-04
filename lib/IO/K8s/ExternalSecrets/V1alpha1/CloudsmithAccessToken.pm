package IO::K8s::ExternalSecrets::V1alpha1::CloudsmithAccessToken;
# ABSTRACT: CloudsmithAccessToken generates Cloudsmith access token using OIDC authentication
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'cloudsmithaccesstokens';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::CloudsmithAccessTokenSpec';

=attr spec

CloudsmithAccessTokenSpec defines the configuration for generating a Cloudsmith access token using OIDC authentication.

=cut

1;
