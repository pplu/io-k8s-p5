package IO::K8s::ExternalSecrets::V1::GitlabAuth;
# ABSTRACT: Auth configures how secret-manager authenticates with a GitLab instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s SecretRef => '+IO::K8s::ExternalSecrets::V1::GitlabSecretRef', { required => 'schema' };

=attr SecretRef

GitlabSecretRef contains the secret reference for GitLab authentication credentials.

=cut

1;
