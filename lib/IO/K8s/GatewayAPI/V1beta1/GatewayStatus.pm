package IO::K8s::GatewayAPI::V1beta1::GatewayStatus;
# ABSTRACT: Status defines the current state of Gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addresses            => ['+IO::K8s::GatewayAPI::V1beta1::GatewayStatusAddress'];
k8s attachedListenerSets => Int;
k8s conditions           => ['Meta::V1::Condition'], { default => [{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Accepted'},{'lastTransitionTime' => '1970-01-01T00:00:00Z','message' => 'Waiting for controller','reason' => 'Pending','status' => 'Unknown','type' => 'Programmed'}] };
k8s listeners            => ['+IO::K8s::GatewayAPI::V1beta1::ListenerStatus'];

=attr addresses

Addresses lists the network addresses that have been bound to the
Gateway.

This list may differ from the addresses provided in the spec under some
conditions:

  * no addresses are specified, all addresses are dynamically assigned
  * a combination of specified and dynamic addresses are assigned
  * a specified address was unusable (e.g. already in use)

=cut

=attr attachedListenerSets

AttachedListenerSets represents the total number of ListenerSets that have been
successfully attached to this Gateway.

A ListenerSet is successfully attached to a Gateway when all the following conditions are met:
- The ListenerSet is selected by the Gateway's AllowedListeners field
- The ListenerSet has a valid ParentRef selecting the Gateway
- The ListenerSet's status has the condition "Accepted: true"

Uses for this field include troubleshooting AttachedListenerSets attachment and
measuring blast radius/impact of changes to a Gateway.

=cut

=attr conditions

Conditions describe the current conditions of the Gateway.

Implementations should prefer to express Gateway conditions
using the `GatewayConditionType` and `GatewayConditionReason`
constants so that operators and tools can converge on a common
vocabulary to describe Gateway state.

Known condition types are:

* "Accepted"
* "Programmed"
* "Ready"

=cut

=attr listeners

Listeners provide status for each unique listener port defined in the Spec.

=cut

1;
