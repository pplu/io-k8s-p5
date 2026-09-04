package IO::K8s::ExternalSecrets::V1::JwtAuthCredentials;
# ABSTRACT: JwtAuthCredentials represents the credentials for JWT authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s identityId => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };
k8s jwt        => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr identityId

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr jwt

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
