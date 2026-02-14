package IO::K8s::Api::Core::V1::Event;
# ABSTRACT: Event is a report of an event somewhere in the cluster.  Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.
our $VERSION = '1.002';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Event is a report of an event somewhere in the cluster.  Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s action => Str;

=attr action

What action was taken/failed regarding to the Regarding object.


=cut

k8s count => Int;

=attr count

The number of times this event has occurred.


=cut

k8s eventTime => Str;

=attr eventTime

Time when this Event was first observed.


=cut

k8s firstTimestamp => Str;

=attr firstTimestamp

The time at which the event was first recorded. (Time of server receipt is in TypeMeta.)


=cut

k8s involvedObject => 'Core::V1::ObjectReference', 'required';

=attr involvedObject

The object that this event is about.


=cut

k8s lastTimestamp => Str;

=attr lastTimestamp

The time at which the most recent occurrence of this event was recorded.


=cut

k8s message => Str;

=attr message

A human-readable description of the status of this operation.


=cut

k8s reason => Str;

=attr reason

This should be a short, machine understandable string that gives the reason for the transition into the object's current status.


=cut

k8s related => 'Core::V1::ObjectReference';

=attr related

Optional secondary object for more complex actions.


=cut

k8s reportingComponent => Str;

=attr reportingComponent

Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`.


=cut

k8s reportingInstance => Str;

=attr reportingInstance

ID of the controller instance, e.g. `kubelet-xyzf`.


=cut

k8s series => 'Core::V1::EventSeries';

=attr series

Data about the Event series this event represents or nil if it's a singleton Event.


=cut

k8s source => 'Core::V1::EventSource';

=attr source

The component reporting this event. Should be a short machine understandable string.


=cut

k8s type => Str;

=attr type

Type of this event (Normal, Warning), new types could be added in the future


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#event-v1-core>


=cut
1;
