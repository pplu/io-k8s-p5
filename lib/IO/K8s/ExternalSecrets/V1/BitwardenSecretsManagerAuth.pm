package IO::K8s::ExternalSecrets::V1::BitwardenSecretsManagerAuth;
# ABSTRACT: Auth configures how secret-manager authenticates with a bitwarden machine account instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::BitwardenSecretsManagerSecretRef', { required => 'schema' };

=attr secretRef

BitwardenSecretsManagerSecretRef contains the credential ref to the bitwarden instance.

=cut

1;
