package IO::K8s::ExternalSecrets::V1alpha1::QuayAccessToken;
# ABSTRACT: QuayAccessToken generates Quay oauth token for pulling/pushing images
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'quayaccesstokens';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::QuayAccessTokenSpec';

=attr spec

QuayAccessTokenSpec defines the desired state to generate a Quay access token.

=cut

1;
