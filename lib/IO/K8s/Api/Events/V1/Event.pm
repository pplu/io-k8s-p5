package IO::K8s::Api::Events::V1::Event;
# ABSTRACT: Event is a report of an event somewhere in the cluster. It generally denotes some state change in the system. Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.
our $VERSION = '1.003';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

Event is a report of an event somewhere in the cluster. It generally denotes some state change in the system. Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s action => Str;

=attr action

action is what action was taken/failed regarding to the regarding object. It is machine-readable. This field cannot be empty for new Events and it can have at most 128 characters.


=cut

k8s deprecatedCount => Int;

=attr deprecatedCount

deprecatedCount is the deprecated field assuring backward compatibility with core.v1 Event type.


=cut

k8s deprecatedFirstTimestamp => Str;

=attr deprecatedFirstTimestamp

deprecatedFirstTimestamp is the deprecated field assuring backward compatibility with core.v1 Event type.


=cut

k8s deprecatedLastTimestamp => Str;

=attr deprecatedLastTimestamp

deprecatedLastTimestamp is the deprecated field assuring backward compatibility with core.v1 Event type.


=cut

k8s deprecatedSource => 'Core::V1::EventSource';

=attr deprecatedSource

deprecatedSource is the deprecated field assuring backward compatibility with core.v1 Event type.


=cut

k8s eventTime => Str, 'required';

=attr eventTime

eventTime is the time when this Event was first observed. It is required.


=cut

k8s note => Str;

=attr note

note is a human-readable description of the status of this operation. Maximal length of the note is 1kB, but libraries should be prepared to handle values up to 64kB.


=cut

k8s reason => Str;

=attr reason

reason is why the action was taken. It is human-readable. This field cannot be empty for new Events and it can have at most 128 characters.


=cut

k8s regarding => 'Core::V1::ObjectReference';

=attr regarding

regarding contains the object this Event is about. In most cases it's an Object reporting controller implements, e.g. ReplicaSetController implements ReplicaSets and this event is emitted because it acts on some changes in a ReplicaSet object.


=cut

k8s related => 'Core::V1::ObjectReference';

=attr related

related is the optional secondary object for more complex actions. E.g. when regarding object triggers a creation or deletion of related object.


=cut

k8s reportingController => Str;

=attr reportingController

reportingController is the name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`. This field cannot be empty for new Events.


=cut

k8s reportingInstance => Str;

=attr reportingInstance

reportingInstance is the ID of the controller instance, e.g. `kubelet-xyzf`. This field cannot be empty for new Events and it can have at most 128 characters.


=cut

k8s series => 'Events::V1::EventSeries';

=attr series

series is data about the Event series this event represents or nil if it's a singleton Event.


=cut

k8s type => Str;

=attr type

type is the type of this event (Normal, Warning), new types could be added in the future. It is machine-readable. This field cannot be empty for new Events.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#event-v1-events.k8s.io>


=cut
1;
