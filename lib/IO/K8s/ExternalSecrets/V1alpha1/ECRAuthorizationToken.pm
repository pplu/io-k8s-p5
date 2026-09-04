package IO::K8s::ExternalSecrets::V1alpha1::ECRAuthorizationToken;
# ABSTRACT: ECRAuthorizationToken uses the GetAuthorizationToken API to retrieve an authorization token.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'ecrauthorizationtokens';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::ECRAuthorizationTokenSpec';

=attr spec

ECRAuthorizationTokenSpec defines the desired state to generate an AWS ECR authorization token.

=cut

1;
