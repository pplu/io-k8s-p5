package IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::Condition;
# ABSTRACT: Condition contains details for one aspect of the current state of this API Resource.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s lastTransitionTime => Time, 'required';

=attr lastTransitionTime

lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.

=cut

k8s message => Str, 'required';

=attr message

message is a human readable message indicating details about the transition. This may be an empty string.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance.

=cut

k8s reason => Str, 'required';

=attr reason

reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty.

=cut

k8s status => Str, 'required';

=attr status

status of the condition, one of True, False, Unknown.

=cut

k8s type => Str, 'required';

=attr type

type of condition in CamelCase or in foo.example.com/CamelCase.

=cut

1;
