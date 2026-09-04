package IO::K8s::ExternalSecrets::V1::BitwardenSecretsManagerSecretRef;
# ABSTRACT: BitwardenSecretsManagerSecretRef contains the credential ref to the bitwarden instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s credentials => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr credentials

AccessToken used for the bitwarden instance.

=cut

1;
