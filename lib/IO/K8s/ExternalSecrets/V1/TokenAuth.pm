package IO::K8s::ExternalSecrets::V1::TokenAuth;
# ABSTRACT: use static token to authenticate with
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s bearerToken => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr bearerToken

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
