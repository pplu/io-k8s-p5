package IO::K8s::ExternalSecrets::V1::SecretStoreStatus;
# ABSTRACT: SecretStoreStatus defines the observed state of the SecretStore.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s capabilities => Str;
k8s conditions   => ['Core::V1::NamespaceCondition'];

=attr capabilities

SecretStoreCapabilities defines the possible operations a SecretStore can do.

=cut

=attr conditions

No description in the upstream schema.

=cut

1;
