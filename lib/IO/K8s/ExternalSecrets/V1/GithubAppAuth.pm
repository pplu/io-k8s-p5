package IO::K8s::ExternalSecrets::V1::GithubAppAuth;
# ABSTRACT: auth configures how secret-manager authenticates with a Github instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s privateKey => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr privateKey

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
