package IO::K8s::ExternalSecrets::V1::BarbicanProviderPasswordRef;
# ABSTRACT: BarbicanProviderPasswordRef defines a reference to a secret containing password for the Barbican provider.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s secretRef => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector', { required => 'schema' };

=attr secretRef

SecretKeySelector is a reference to a specific 'key' within a Secret resource.
In some instances, `key` is a required field.

=cut

1;
