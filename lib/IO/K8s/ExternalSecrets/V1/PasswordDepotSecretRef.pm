package IO::K8s::ExternalSecrets::V1::PasswordDepotSecretRef;
# ABSTRACT: PasswordDepotSecretRef contains the secret reference for Password Depot authentication.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s credentials => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr credentials

Username / Password is used for authentication.

=cut

1;
