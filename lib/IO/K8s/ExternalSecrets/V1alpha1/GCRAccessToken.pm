package IO::K8s::ExternalSecrets::V1alpha1::GCRAccessToken;
# ABSTRACT: GCRAccessToken generates an GCP access token that can be used to authenticate with GCR.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'gcraccesstokens';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::GCRAccessTokenSpec';

=attr spec

GCRAccessTokenSpec defines the desired state to generate a Google Container Registry access token.

=cut

1;
