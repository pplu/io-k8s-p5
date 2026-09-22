package IO::K8s::ExternalSecrets::V1alpha1::PushSecretStatusCondition;
# ABSTRACT: PushSecretStatusCondition indicates the status of the PushSecret.
our $VERSION = '1.109';
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

PushSecretConditionType indicates the condition of the PushSecret.

=cut

1;
