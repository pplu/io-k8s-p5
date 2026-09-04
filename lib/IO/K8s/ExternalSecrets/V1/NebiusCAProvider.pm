package IO::K8s::ExternalSecrets::V1::NebiusCAProvider;
# ABSTRACT: The provider for the CA bundle to use to validate NebiusMysterybox server certificate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s certSecretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr certSecretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
