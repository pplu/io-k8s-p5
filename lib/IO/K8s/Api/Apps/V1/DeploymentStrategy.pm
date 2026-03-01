package IO::K8s::Api::Apps::V1::DeploymentStrategy;
# ABSTRACT: DeploymentStrategy describes how to replace existing pods with new ones.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s rollingUpdate => 'Apps::V1::RollingUpdateDeployment';

=attr rollingUpdate

Rolling update config params. Present only if DeploymentStrategyType = RollingUpdate.

=cut

k8s type => Str;

=attr type

Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.

=cut

1;
