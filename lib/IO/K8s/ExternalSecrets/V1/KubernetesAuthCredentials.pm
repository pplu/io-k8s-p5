package IO::K8s::ExternalSecrets::V1::KubernetesAuthCredentials;
# ABSTRACT: KubernetesAuthCredentials represents the credentials for Kubernetes authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s identityId              => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s serviceAccountTokenPath => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr identityId

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr serviceAccountTokenPath

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
