package IO::K8s::GatewayAPI::V1::GatewayClassStatus;
# ABSTRACT: Status defines the current state of GatewayClass.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions        => ['Meta::V1::Condition'], { default => [{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Accepted'}] };
k8s supportedFeatures => ['+IO::K8s::GatewayAPI::V1::SupportedFeature'];

=attr conditions

Conditions is the current status from the controller for
this GatewayClass.

Controllers should prefer to publish conditions using values
of GatewayClassConditionType for the type of each Condition.

=cut

=attr supportedFeatures

SupportedFeatures is the set of features the GatewayClass support.
It MUST be sorted in ascending alphabetical order by the Name key.

=cut

1;
