package IO::K8s::ExternalSecrets::V1::NgrokProviderSecretRef;
# ABSTRACT: APIKey is the API Key used to authenticate with ngrok.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr secretRef

SecretRef is a reference to a secret containing the ngrok API key.

=cut

1;
