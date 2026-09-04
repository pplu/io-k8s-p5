package IO::K8s::ExternalSecrets::V1::FortanixProviderSecretRef;
# ABSTRACT: APIKey is the API token to access SDKMS Applications.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr secretRef

SecretRef is a reference to a secret containing the SDKMS API Key.

=cut

1;
