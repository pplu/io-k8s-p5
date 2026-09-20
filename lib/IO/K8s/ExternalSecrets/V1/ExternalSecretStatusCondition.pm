package IO::K8s::ExternalSecrets::V1::ExternalSecretStatusCondition;
# ABSTRACT: ExternalSecretStatusCondition defines a status condition of an ExternalSecret resource.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;
k8s message            => Str;
k8s reason             => Str;
k8s status             => Str, { required => 'schema' };
k8s type               => Str, { required => 'schema', enum => [qw(Ready Deleted)] };

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

ExternalSecretConditionType defines a value type for ExternalSecret conditions.

=cut

1;
