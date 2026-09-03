package IO::K8s::GatewayAPI::V1::ListenerSetStatus;
# ABSTRACT: Status defines the current state of ListenerSet.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s conditions => ['Meta::V1::Condition'], { default => [{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Accepted'},{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Programmed'}] };
k8s listeners  => ['+IO::K8s::GatewayAPI::V1::ListenerEntryStatus'];

=attr conditions

Conditions describe the current conditions of the ListenerSet.

Implementations MUST express ListenerSet conditions using the
`ListenerSetConditionType` and `ListenerSetConditionReason`
constants so that operators and tools can converge on a common
vocabulary to describe ListenerSet state.

Known condition types are:

* "Accepted"
* "Programmed"

=cut

=attr listeners

Listeners provide status for each unique listener port defined in the Spec.

=cut

1;
