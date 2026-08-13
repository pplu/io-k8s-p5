package IO::K8s::Api::Resource::V1beta1::ResourceSliceSpec;
# ABSTRACT: ResourceSliceSpec contains the information published by the driver in one ResourceSlice.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s allNodes => Bool;

=attr allNodes

AllNodes indicates that all nodes have access to the resources in the pool.  Exactly one of NodeName, NodeSelector, AllNodes, and PerDeviceNodeSelection must be set.

=cut

k8s devices => ['Resource::V1beta1::Device'];

=attr devices

Devices lists some or all of the devices in this pool.  Must not have more than 128 entries. If any device uses taints or consumes counters the limit is 64.  Only one of Devices and SharedCounters can be set in a ResourceSlice.

=cut

k8s driver => Str, 'required';

=attr driver

Driver identifies the DRA driver providing the capacity information. A field selector can be used to list only ResourceSlice objects with a certain driver name.  Must be a DNS subdomain and should end with a DNS domain owned by the vendor of the driver. It should use only lower case characters. This field is immutable.

=cut

k8s nodeName => Str;

=attr nodeName

NodeName identifies the node which provides the resources in this pool. A field selector can be used to list only ResourceSlice objects belonging to a certain node.  This field can be used to limit access from nodes to ResourceSlices with the same node name. It also indicates to autoscalers that adding new nodes of the same type as some old node might also make new resources available.  Exactly one of NodeName, NodeSelector, AllNodes, and PerDeviceNodeSelection must be set. This field is immutable.

=cut

k8s nodeSelector => 'Core::V1::NodeSelector';

=attr nodeSelector

NodeSelector defines which nodes have access to the resources in the pool, when that pool is not limited to a single node.  Must use exactly one term.  Exactly one of NodeName, NodeSelector, AllNodes, and PerDeviceNodeSelection must be set.

=cut

k8s perDeviceNodeSelection => Bool;

=attr perDeviceNodeSelection

PerDeviceNodeSelection defines whether the access from nodes to resources in the pool is set on the ResourceSlice level or on each device. If it is set to true, every device defined the ResourceSlice must specify this individually.  Exactly one of NodeName, NodeSelector, AllNodes, and PerDeviceNodeSelection must be set.

=cut

k8s pool => 'Resource::V1beta1::ResourcePool', 'required';

=attr pool

Pool describes the pool that this ResourceSlice belongs to.

=cut

k8s sharedCounters => ['Resource::V1beta1::CounterSet'];

=attr sharedCounters

SharedCounters defines a list of counter sets, each of which has a name and a list of counters available.  The names of the counter sets must be unique in the ResourcePool.  Only one of Devices and SharedCounters can be set in a ResourceSlice.  The maximum number of counter sets is 8.

=cut

1;
