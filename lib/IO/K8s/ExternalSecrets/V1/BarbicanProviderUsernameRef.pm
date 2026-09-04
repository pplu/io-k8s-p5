package IO::K8s::ExternalSecrets::V1::BarbicanProviderUsernameRef;
# ABSTRACT: BarbicanProviderUsernameRef defines a reference to a secret containing username for the Barbican provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s value     => Str;

=attr secretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

=attr value

No description in the upstream schema.

=cut

1;
