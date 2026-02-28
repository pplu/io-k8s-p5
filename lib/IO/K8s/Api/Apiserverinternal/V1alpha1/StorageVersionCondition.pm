package IO::K8s::Api::Apiserverinternal::V1alpha1::StorageVersionCondition;
# ABSTRACT: Describes the state of the storageVersion at a certain point.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;

=attr lastTransitionTime

Last time the condition transitioned from one status to another.

=cut

k8s message => Str, 'required';

=attr message

A human readable message indicating details about the transition.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

If set, this represents the .metadata.generation that the condition was set based upon.

=cut

k8s reason => Str, 'required';

=attr reason

The reason for the condition's last transition.

=cut

k8s status => Str, 'required';

=attr status

Status of the condition, one of True, False, Unknown.

=cut

k8s type => Str, 'required';

=attr type

Type of the condition.

=cut

1;
