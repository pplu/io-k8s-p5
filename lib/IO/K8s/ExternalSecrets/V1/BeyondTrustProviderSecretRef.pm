package IO::K8s::ExternalSecrets::V1::BeyondTrustProviderSecretRef;
# ABSTRACT: ClientSecret is the API OAuth Client Secret.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s value     => Str;

=attr secretRef

SecretRef references a key in a secret that will be used as value.

=cut

=attr value

Value can be specified directly to set a value without using a secret.

=cut

1;
