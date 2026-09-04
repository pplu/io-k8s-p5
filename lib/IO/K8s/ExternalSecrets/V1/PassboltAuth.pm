package IO::K8s::ExternalSecrets::V1::PassboltAuth;
# ABSTRACT: Auth defines the information necessary to authenticate against Passbolt Server
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s passwordSecretRef   => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s privateKeySecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr passwordSecretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr privateKeySecretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
