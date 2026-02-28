package IO::K8s::ApiextensionsApiserver::Pkg::Apis::Apiextensions::V1::CustomResourceDefinitionCondition;
# ABSTRACT: CustomResourceDefinitionCondition contains details for the current condition of this pod.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s lastTransitionTime => Time;

=attr lastTransitionTime

lastTransitionTime last time the condition transitioned from one status to another.

=cut

k8s message => Str;

=attr message

message is a human-readable message indicating details about last transition.

=cut

k8s reason => Str;

=attr reason

reason is a unique, one-word, CamelCase reason for the condition's last transition.

=cut

k8s status => Str, 'required';

=attr status

status is the status of the condition. Can be True, False, Unknown.

=cut

k8s type => Str, 'required';

=attr type

type is the type of the condition. Types include Established, NamesAccepted and Terminating.

=cut

1;
