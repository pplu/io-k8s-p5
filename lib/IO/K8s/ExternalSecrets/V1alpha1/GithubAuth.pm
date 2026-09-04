package IO::K8s::ExternalSecrets::V1alpha1::GithubAuth;
# ABSTRACT: Auth configures how ESO authenticates with a Github instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s privateKey => '+IO::K8s::ExternalSecrets::V1alpha1::GithubSecretRef', { required => 'schema' };

=attr privateKey

GithubSecretRef references a secret containing GitHub credentials.

=cut

1;
