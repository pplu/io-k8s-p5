package IO::K8s::ExternalSecrets::V1::GitlabSecretRef;
# ABSTRACT: GitlabSecretRef contains the secret reference for GitLab authentication credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessToken => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr accessToken

AccessToken is used for authentication.

=cut

1;
