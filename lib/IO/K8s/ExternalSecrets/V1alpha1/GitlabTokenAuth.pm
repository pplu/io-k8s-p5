package IO::K8s::ExternalSecrets::V1alpha1::GitlabTokenAuth;
# ABSTRACT: Auth configures how ESO authenticates with the GitLab API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s token => '+IO::K8s::ExternalSecrets::V1alpha1::GitlabDeployTokenSecretRef', { required => 'schema' };

=attr token

Token references a secret containing a GitLab access token (personal, group, or
project) with the api scope and at least the Maintainer role on the target.

=cut

1;
