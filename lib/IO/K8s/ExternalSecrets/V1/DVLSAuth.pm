package IO::K8s::ExternalSecrets::V1::DVLSAuth;
# ABSTRACT: Auth defines the authentication method to use.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::DVLSAuthSecretRef', { required => 'schema' };

=attr secretRef

SecretRef contains the Application ID and Application Secret for authentication.

=cut

1;
