package IO::K8s::Api::Batch::V1::PodFailurePolicyOnPodConditionsPattern;
# ABSTRACT: PodFailurePolicyOnPodConditionsPattern describes a pattern for matching an actual pod condition type.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s status => Str, 'required';

=attr status

Specifies the required Pod condition status. To match a pod condition it is required that the specified status equals the pod condition status. Defaults to True.

=cut

k8s type => Str, 'required';

=attr type

Specifies the required Pod condition type. To match a pod condition it is required that specified type equals the pod condition type.

=cut

1;
