package IO::K8s::KubeAggregator::Pkg::Apis::Apiregistration::V1::APIServiceCondition;
# ABSTRACT: APIServiceCondition describes the state of an APIService at a particular point
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;

=attr lastTransitionTime

Last time the condition transitioned from one status to another.

=cut

k8s message => Str;

=attr message

Human-readable message indicating details about last transition.

=cut

k8s reason => Str;

=attr reason

Unique, one-word, CamelCase reason for the condition's last transition

=cut

k8s status => Str, 'required';

=attr status

Status is the status of the condition. Can be True, False, Unknown.

=cut

k8s type => Str, 'required';

=attr type

Type is the type of the condition.

=cut

1;
