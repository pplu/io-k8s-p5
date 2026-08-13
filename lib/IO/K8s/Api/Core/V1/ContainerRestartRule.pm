package IO::K8s::Api::Core::V1::ContainerRestartRule;
# ABSTRACT: ContainerRestartRule describes how a container exit is handled.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s action => Str, 'required';

=attr action

Specifies the action taken on a container exit if the requirements are satisfied. The only possible value is "Restart" to restart the container.

=cut

k8s exitCodes => 'Core::V1::ContainerRestartRuleOnExitCodes';

=attr exitCodes

Represents the exit codes to check on container exits.

=cut

1;
