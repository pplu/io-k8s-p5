package IO::K8s::ExternalSecrets::V1::OnePasswordSDKAuth;
# ABSTRACT: Auth defines the information necessary to authenticate against OnePassword API.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s serviceAccountSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr serviceAccountSecretRef

ServiceAccountSecretRef points to the secret containing the token to access 1Password vault.

=cut

1;
