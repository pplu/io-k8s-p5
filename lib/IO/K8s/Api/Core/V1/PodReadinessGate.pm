package IO::K8s::Api::Core::V1::PodReadinessGate;
# ABSTRACT: PodReadinessGate contains the reference to a pod condition
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s conditionType => Str, 'required';

=attr conditionType

ConditionType refers to a condition in the pod's condition list with matching type.

=cut

1;
