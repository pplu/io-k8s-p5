package IO::K8s::ExternalSecrets::V1::PreviderAuthSecretRef;
# ABSTRACT: PreviderAuthSecretRef holds secret references for Previder Vault credentials.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessToken => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr accessToken

The AccessToken is used for authentication

=cut

1;
