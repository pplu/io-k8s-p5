package IO::K8s::Api::Lifecycle::V1alpha1::ResponderStatus;
# ABSTRACT: ResponderStatus represents the last observed status of the eviction process of the responder. It should be only updated by the designated responder whose name is .name field.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s completionTime => Time;

=attr completionTime

completionTime tracks the time at which the Responder stopped processing the eviction request. Completion means that the responders has either fully or partially completed the eviction process, which may have resulted in target eviction (e.g. pod termination). It should reflect the present time when set. This field becomes immutable once set.

=cut

k8s expectedCompletionTime => Time;

=attr expectedCompletionTime

expectedCompletionTime is the time at which the eviction process step is expected to end for the responder. The time cannot be set to the past. May be omitted if no estimate can be made.

=cut

k8s heartbeatTime => Time;

=attr heartbeatTime

heartbeatTime is the last time at which the eviction process was reported to be in progress by the responder. It should reflect the present time when set. Responders should avoid heartbeats more frequent than 20 seconds to avoid overloading the control-plane.

=cut

k8s message => Str;

=attr message

message provides human-readable details about the state of the responder and the eviction process. Maximum length is 4000 characters.

=cut

k8s name => Str, 'required';

=attr name

name allows you to identify the responder reacting to the Eviction.

It must be a valid domain-prefixed key (such as "acme.io/foo"). This field is initialized by Kubernetes and must be unique for each responder. This field is required.

=cut

k8s startTime => Time;

=attr startTime

startTime tracks the time at which this responder was designated as active and should start processing the eviction request. It should reflect the present time when set. This field is initialized by Kubernetes when this responder becomes active. This field becomes immutable once set.

=cut

1;
