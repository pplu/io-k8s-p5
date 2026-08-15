package IO::K8s::Api::Core::V1::ContainerRestartRuleOnExitCodes;
# ABSTRACT: ContainerRestartRuleOnExitCodes describes the condition for handling an exited container based on its exit codes.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s operator => Str, 'required';

=attr operator

Represents the relationship between the container exit code(s) and the specified values. Possible values are: - In: the requirement is satisfied if the container exit code is in the set of specified values. - NotIn: the requirement is satisfied if the container exit code is not in the set of specified values. Additional values are considered to be added in the future. Clients should read the 'reason' field to determine if the value is supported by the current version of Kubernetes.

=cut

k8s values => [Int];

=attr values

Specifies the set of values to check for container exit codes. At most 255 elements are allowed.

=cut

1;
