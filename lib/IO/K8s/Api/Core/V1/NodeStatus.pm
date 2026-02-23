package IO::K8s::Api::Core::V1::NodeStatus;
# ABSTRACT: NodeStatus is information about the current status of a node.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s addresses => ['Core::V1::NodeAddress'];

=attr addresses

List of addresses reachable to the node. Queried from cloud provider, if available. More info: https://kubernetes.io/docs/concepts/nodes/node/#addresses Note: This field is declared as mergeable, but the merge key is not sufficiently unique, which can cause data corruption when it is merged. Callers should instead use a full-replacement patch. See https://pr.k8s.io/79391 for an example. Consumers should assume that addresses can change during the lifetime of a Node. However, there are some exceptions where this may not be possible, such as Pods that inherit a Node's address in its own status or consumers of the downward API (status.hostIP).

=cut

k8s allocatable => { Str => 1 };

=attr allocatable

Allocatable represents the resources of a node that are available for scheduling. Defaults to Capacity.

=cut

k8s capacity => { Str => 1 };

=attr capacity

Capacity represents the total resources of a node. More info: https://kubernetes.io/docs/reference/node/node-status/#capacity

=cut

k8s conditions => ['Core::V1::NodeCondition'];

=attr conditions

Conditions is an array of current observed node conditions. More info: https://kubernetes.io/docs/concepts/nodes/node/#condition

=cut

k8s config => 'Core::V1::NodeConfigStatus';

=attr config

Status of the config assigned to the node via the dynamic Kubelet config feature.

=cut

k8s daemonEndpoints => 'Core::V1::NodeDaemonEndpoints';

=attr daemonEndpoints

Endpoints of daemons running on the Node.

=cut

k8s features => 'Core::V1::NodeFeatures';

=attr features

Features describes the set of features implemented by the CRI implementation.

=cut

k8s images => ['Core::V1::ContainerImage'];

=attr images

List of container images on this node

=cut

k8s nodeInfo => 'Core::V1::NodeSystemInfo';

=attr nodeInfo

Set of ids/uuids to uniquely identify the node. More info: https://kubernetes.io/docs/concepts/nodes/node/#info

=cut

k8s phase => Str;

=attr phase

NodePhase is the recently observed lifecycle phase of the node. More info: https://kubernetes.io/docs/concepts/nodes/node/#phase The field is never populated, and now is deprecated.

=cut

k8s runtimeHandlers => ['Core::V1::NodeRuntimeHandler'];

=attr runtimeHandlers

The available runtime handlers.

=cut

k8s volumesAttached => ['Core::V1::AttachedVolume'];

=attr volumesAttached

List of volumes that are attached to the node.

=cut

k8s volumesInUse => [Str];

=attr volumesInUse

List of attachable volumes in use (mounted) by the node.

=cut

1;
