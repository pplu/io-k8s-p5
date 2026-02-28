package IO::K8s::Api::Apps::V1::DaemonSetStatus;
# ABSTRACT: DaemonSetStatus represents the current status of a daemon set.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s collisionCount => Int;

=attr collisionCount

Count of hash collisions for the DaemonSet. The DaemonSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision.

=cut

k8s conditions => ['Apps::V1::DaemonSetCondition'];

=attr conditions

Represents the latest available observations of a DaemonSet's current state.

=cut

k8s currentNumberScheduled => Int, 'required';

=attr currentNumberScheduled

The number of nodes that are running at least 1 daemon pod and are supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/

=cut

k8s desiredNumberScheduled => Int, 'required';

=attr desiredNumberScheduled

The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod). More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/

=cut

k8s numberAvailable => Int;

=attr numberAvailable

The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds)

=cut

k8s numberMisscheduled => Int, 'required';

=attr numberMisscheduled

The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/

=cut

k8s numberReady => Int, 'required';

=attr numberReady

numberReady is the number of nodes that should be running the daemon pod and have one or more of the daemon pod running with a Ready Condition.

=cut

k8s numberUnavailable => Int;

=attr numberUnavailable

The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds)

=cut

k8s observedGeneration => Int;

=attr observedGeneration

The most recent generation observed by the daemon set controller.

=cut

k8s updatedNumberScheduled => Int;

=attr updatedNumberScheduled

The total number of nodes that are running updated daemon pod

=cut

1;
