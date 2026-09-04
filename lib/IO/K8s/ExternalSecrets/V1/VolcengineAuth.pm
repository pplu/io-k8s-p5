package IO::K8s::ExternalSecrets::V1::VolcengineAuth;
# ABSTRACT: Auth defines the authentication method to use.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::VolcengineAuthSecretRef';

=attr secretRef

SecretRef defines the static credentials to use for authentication.
If not set, IRSA is used.

=cut

1;
