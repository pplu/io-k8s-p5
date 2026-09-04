package IO::K8s::ExternalSecrets::V1::UniversalAuthCredentials;
# ABSTRACT: UniversalAuthCredentials represents the client credentials for universal authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientId     => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s clientSecret => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr clientId

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr clientSecret

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
