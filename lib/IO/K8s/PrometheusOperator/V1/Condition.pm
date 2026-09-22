package IO::K8s::PrometheusOperator::V1::Condition;
# ABSTRACT: Condition represents the state of the resources associated with the Prometheus, Alertmanager or ThanosRuler resource.
our $VERSION = '1.109';
use IO::K8s::Resource;

k8s lastTransitionTime => Time, { required => 'schema' };
k8s message            => Str;
k8s observedGeneration => Int;
k8s reason             => Str;
k8s status             => Str, { required => 'schema' };
k8s type               => Str, { required => 'schema' };

=attr lastTransitionTime

lastTransitionTime is the time of the last update to the current status
property.

=cut

=attr message

message defines human-readable message indicating details for the
condition's last transition.

=cut

=attr observedGeneration

observedGeneration defines the .metadata.generation that the condition was
set based upon. For instance, if C<.metadata.generation> is currently 12,
but the C<.status.conditions[].observedGeneration> is 9, the condition is
out of date with respect to the current state of the instance.

=cut

=attr reason

reason for the condition's last transition.

=cut

=attr status

status of the condition.

=cut

=attr type

type of the condition being reported.

=cut

1;
