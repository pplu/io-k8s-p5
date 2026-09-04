package IO::K8s::ExternalSecrets::V1alpha1::GitlabDeployTokenSecretRef;
# ABSTRACT: Token references a secret containing a GitLab access token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr secretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
