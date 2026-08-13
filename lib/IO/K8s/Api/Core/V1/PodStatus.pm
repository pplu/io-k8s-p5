package IO::K8s::Api::Core::V1::PodStatus;
# ABSTRACT: PodStatus represents information about the status of a pod. Status may trail the actual state of a system, especially if the node that hosts the pod cannot contact the control plane.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s allocatedResources => { Str => 1 };

=attr allocatedResources

AllocatedResources is the total amount of CPU and Memory resources allocated to the pod's containers by the node. It supports specifying Requests and Limits for "cpu" and "memory" resource names only. Kubelet sets this value to the pod-level resources.requests upon successful pod admission and after successfully admitting desired pod-level resource resize.

=cut

k8s conditions => ['Core::V1::PodCondition'];

=attr conditions

Current service state of pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-conditions

=cut

k8s containerStatuses => ['Core::V1::ContainerStatus'];

=attr containerStatuses

The list has one entry per container in the manifest. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-and-container-status

=cut

k8s ephemeralContainerStatuses => ['Core::V1::ContainerStatus'];

=attr ephemeralContainerStatuses

Status for any ephemeral containers that have run in this pod.

=cut

k8s extendedResourceClaimStatus => 'Core::V1::PodExtendedResourceClaimStatus';

=attr extendedResourceClaimStatus

Status of extended resource claims.

=cut

k8s hostIP => Str;

=attr hostIP

hostIP holds the IP address of the host to which the pod is assigned. Empty if the pod has not started yet. A pod can be assigned to a node that has a problem in kubelet which in turns mean that HostIP will not be updated even if there is a node is assigned to pod

=cut

k8s hostIPs => ['Core::V1::HostIP'];

=attr hostIPs

hostIPs holds the IP addresses allocated to the host. If this field is specified, the first entry must match the hostIP field. This list is empty if the pod has not started yet. A pod can be assigned to a node that has a problem in kubelet which in turns means that HostIPs will not be updated even if there is a node is assigned to this pod.

=cut

k8s initContainerStatuses => ['Core::V1::ContainerStatus'];

=attr initContainerStatuses

The list has one entry per init container in the manifest. The most recent successful init container will have ready = true, the most recently started container will have startTime set. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-and-container-status

=cut

k8s message => Str;

=attr message

A human readable message indicating details about why the pod is in this condition.

=cut

k8s nodeAllocatableResourceClaimStatuses => ['Core::V1::NodeAllocatableResourceClaimStatus'];

=attr nodeAllocatableResourceClaimStatuses

Status of node-allocatable resources backed by DRA resource claims.

=cut

k8s nominatedNodeName => Str;

=attr nominatedNodeName

nominatedNodeName is set only when this pod preempts other pods on the node, but it cannot be scheduled right away as preemption victims receive their graceful termination periods. This field does not guarantee that the pod will be scheduled on this node. Scheduler may decide to place the pod elsewhere if other nodes become available sooner. Scheduler may also decide to give the resources on this node to a higher priority pod that is created after preemption. As a result, this field may be different than PodSpec.nodeName when the pod is scheduled.

=cut

k8s observedGeneration => Int;

=attr observedGeneration

If set, this represents the .metadata.generation that the pod status was set based upon. This is an alpha field. Enable PodObservedGenerationTracking to be able to use this field.

=cut

k8s phase => Str;

=attr phase

The phase of a Pod is a simple, high-level summary of where the Pod is in its lifecycle. The conditions array, the reason and message fields, and the individual container status arrays contain more detail about the pod's status. There are five possible phase values:

Pending: The pod has been accepted by the Kubernetes system, but one or more of the container images has not been created. This includes time before being scheduled as well as time spent downloading images over the network, which could take a while. Running: The pod has been bound to a node, and all of the containers have been created. At least one container is still running, or is in the process of starting or restarting. Succeeded: All containers in the pod have terminated in success, and will not be restarted. Failed: All containers in the pod have terminated, and at least one container has terminated in failure. The container either exited with non-zero status or was terminated by the system. Unknown: For some reason the state of the pod could not be obtained, typically due to an error in communicating with the host of the pod.

More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#pod-phase

=cut

k8s podIP => Str;

=attr podIP

podIP address allocated to the pod. Routable at least within the cluster. Empty if not yet allocated.

=cut

k8s podIPs => ['Core::V1::PodIP'];

=attr podIPs

podIPs holds the IP addresses allocated to the pod. If this field is specified, the 0th entry must match the podIP field. Pods may be allocated at most 1 value for each of IPv4 and IPv6. This list is empty if no IPs have been allocated yet.

=cut

k8s qosClass => Str;

=attr qosClass

The Quality of Service (QOS) classification assigned to the pod based on resource requirements See PodQOSClass type for available QOS classes More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-qos/#quality-of-service-classes

=cut

k8s reason => Str;

=attr reason

A brief CamelCase message indicating details about why the pod is in this state. e.g. 'Evicted'

=cut

k8s resize => Str;

=attr resize

Status of resources resize desired for pod's containers. It is empty if no resources resize is pending. Any changes to container resources will automatically set this to "Proposed" Deprecated: Resize status is moved to two pod conditions PodResizePending and PodResizeInProgress. PodResizePending will track states where the container requests do not match pod status. PodResizeInProgress will track in-progress resizes, and populate its reason field when it is unable to complete the resize.

=cut

k8s resourceClaimStatuses => ['Core::V1::PodResourceClaimStatus'];

=attr resourceClaimStatuses

Status of resource claims.

=cut

k8s resources => 'Core::V1::ResourceRequirements';

=attr resources

Resources is the total amount of CPU and Memory resources allocated to the pod's containers by the node's kubelet. It supports specifying Requests and Limits for "cpu" and "memory" resource names only. ResourceClaims are not supported.

This value is only set when PodLevelResources feature gate is enabled and the total container resource requests do not exceed pod-level resource requests, or if the resource requests are equal.

=cut

k8s startTime => Time;

=attr startTime

RFC 3339 date and time at which the object was acknowledged by the Kubelet. This is before the Kubelet pulled the container image(s) for the pod.

=cut

1;
