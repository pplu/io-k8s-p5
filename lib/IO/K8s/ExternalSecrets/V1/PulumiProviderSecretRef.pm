package IO::K8s::ExternalSecrets::V1::PulumiProviderSecretRef;
# ABSTRACT: AccessToken authenticates using a Pulumi access token stored in a Kubernetes Secret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';

=attr secretRef

SecretRef is a reference to a secret containing the Pulumi API token.

=cut

1;
