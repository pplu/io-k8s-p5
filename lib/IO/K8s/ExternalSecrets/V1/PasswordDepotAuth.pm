package IO::K8s::ExternalSecrets::V1::PasswordDepotAuth;
# ABSTRACT: Auth configures how secret-manager authenticates with a Password Depot instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::PasswordDepotSecretRef', { required => 'schema' };

=attr secretRef

PasswordDepotSecretRef contains the secret reference for Password Depot authentication.

=cut

1;
