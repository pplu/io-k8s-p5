package IO::K8s::ExternalSecrets::V1alpha1::GitlabDeployToken;
# ABSTRACT: GitlabDeployToken generates a GitLab deploy token.
our $VERSION = '1.108';
use IO::K8s::APIObject
    api_version     => 'generators.external-secrets.io/v1alpha1',
    resource_plural => 'gitlabdeploytokens';
with 'IO::K8s::Role::Namespaced';

k8s spec => '+IO::K8s::ExternalSecrets::V1alpha1::GitlabDeployTokenSpec';

=attr spec

GitlabDeployTokenSpec defines the desired state to generate a GitLab deploy token.

=cut

1;
