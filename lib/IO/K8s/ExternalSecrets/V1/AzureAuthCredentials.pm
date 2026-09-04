package IO::K8s::ExternalSecrets::V1::AzureAuthCredentials;
# ABSTRACT: AzureAuthCredentials represents the credentials for Azure authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s identityId => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s resource   => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr identityId

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr resource

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
