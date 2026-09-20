package IO::K8s::ExternalSecrets::V1::SecretStoreStatusCondition;
# ABSTRACT: SecretStoreStatusCondition contains condition information for a SecretStore.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;
k8s message            => Str;
k8s reason             => Str;
k8s status             => Str, { required => 'schema' };
k8s type               => Str, { required => 'schema' };

=attr lastTransitionTime

No description in the upstream schema.

=cut

=attr message

No description in the upstream schema.

=cut

=attr reason

No description in the upstream schema.

=cut

=attr status

No description in the upstream schema.

=cut

=attr type

SecretStoreConditionType represents the condition of the SecretStore.

=cut

1;
