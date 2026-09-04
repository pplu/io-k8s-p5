package IO::K8s::ExternalSecrets::V1::TokenAuthCredentials;
# ABSTRACT: TokenAuthCredentials represents the credentials for access token-based authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessToken => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr accessToken

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
