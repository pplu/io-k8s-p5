package IO::K8s::Api::Core::V1::PodSpec;
# ABSTRACT: PodSpec is a description of a pod.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s activeDeadlineSeconds => Int;

=attr activeDeadlineSeconds

Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer.

=cut

k8s affinity => 'Core::V1::Affinity';

=attr affinity

If specified, the pod's scheduling constraints

=cut

k8s automountServiceAccountToken => Bool;

=attr automountServiceAccountToken

AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.

=cut

k8s containers => ['Core::V1::Container'], 'required';

=attr containers

List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated.

=cut

k8s dnsConfig => 'Core::V1::PodDNSConfig';

=attr dnsConfig

Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.

=cut

k8s dnsPolicy => Str;

=attr dnsPolicy

Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'.

=cut

k8s enableServiceLinks => Bool;

=attr enableServiceLinks

EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true.

=cut

k8s ephemeralContainers => ['Core::V1::EphemeralContainer'];

=attr ephemeralContainers

List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource.

=cut

k8s hostAliases => ['Core::V1::HostAlias'];

=attr hostAliases

HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified.

=cut

k8s hostIPC => Bool;

=attr hostIPC

Use the host's ipc namespace. Optional: Default to false.

=cut

k8s hostNetwork => Bool;

=attr hostNetwork

Host networking requested for this pod. Use the host's network namespace. If this option is set, the ports that will be used must be specified. Default to false.

=cut

k8s hostPID => Bool;

=attr hostPID

Use the host's pid namespace. Optional: Default to false.

=cut

k8s hostUsers => Bool;

=attr hostUsers

Use the host's user namespace. Optional: Default to true. If set to true or not present, the pod will be run in the host user namespace, useful for when the pod needs a feature only available to the host user namespace, such as loading a kernel module with CAP_SYS_MODULE. When set to false, a new userns is created for the pod. Setting false is useful for mitigating container breakout vulnerabilities even allowing users to run their containers as root without actually having root privileges on the host. This field is alpha-level and is only honored by servers that enable the UserNamespacesSupport feature.

=cut

k8s hostname => Str;

=attr hostname

Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value.

=cut

k8s imagePullSecrets => ['Core::V1::LocalObjectReference'];

=attr imagePullSecrets

ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod

=cut

k8s initContainers => ['Core::V1::Container'];

=attr initContainers

List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/

=cut

k8s nodeName => Str;

=attr nodeName

NodeName indicates in which node this pod is scheduled. If empty, this pod is a candidate for scheduling by the scheduler defined in schedulerName. Once this field is set, the kubelet for this node becomes responsible for the lifecycle of this pod. This field should not be used to express a desire for the pod to be scheduled on a specific node. https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodename

=cut

k8s nodeSelector => { Str => 1 };

=attr nodeSelector

NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/

=cut

k8s os => 'Core::V1::PodOS';

=attr os

Specifies the OS of the containers in the pod. Some pod and container fields are restricted if this is set.

If the OS field is set to linux, the following fields must be unset: -securityContext.windowsOptions

If the OS field is set to windows, following fields must be unset: - spec.hostPID - spec.hostIPC - spec.hostUsers - spec.securityContext.appArmorProfile - spec.securityContext.seLinuxOptions - spec.securityContext.seccompProfile - spec.securityContext.fsGroup - spec.securityContext.fsGroupChangePolicy - spec.securityContext.sysctls - spec.shareProcessNamespace - spec.securityContext.runAsUser - spec.securityContext.runAsGroup - spec.securityContext.supplementalGroups - spec.securityContext.supplementalGroupsPolicy - spec.containers[*].securityContext.appArmorProfile - spec.containers[*].securityContext.seLinuxOptions - spec.containers[*].securityContext.seccompProfile - spec.containers[*].securityContext.capabilities - spec.containers[*].securityContext.readOnlyRootFilesystem - spec.containers[*].securityContext.privileged - spec.containers[*].securityContext.allowPrivilegeEscalation - spec.containers[*].securityContext.procMount - spec.containers[*].securityContext.runAsUser - spec.containers[*].securityContext.runAsGroup

=cut

k8s overhead => { Str => 1 };

=attr overhead

Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md

=cut

k8s preemptionPolicy => Str;

=attr preemptionPolicy

PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset.

=cut

k8s priority => Int;

=attr priority

The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority.

=cut

k8s priorityClassName => Str;

=attr priorityClassName

If specified, indicates the pod's priority. "system-node-critical" and "system-cluster-critical" are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default.

=cut

k8s readinessGates => ['Core::V1::PodReadinessGate'];

=attr readinessGates

If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to "True" More info: https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates

=cut

k8s resourceClaims => ['Core::V1::PodResourceClaim'];

=attr resourceClaims

ResourceClaims defines which ResourceClaims must be allocated and reserved before the Pod is allowed to start. The resources will be made available to those containers which consume them by name.

This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.

This field is immutable.

=cut

k8s restartPolicy => Str;

=attr restartPolicy

Restart policy for all containers within the pod. One of Always, OnFailure, Never. In some contexts, only a subset of those values may be permitted. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy

=cut

k8s runtimeClassName => Str;

=attr runtimeClassName

RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class

=cut

k8s schedulerName => Str;

=attr schedulerName

If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler.

=cut

k8s schedulingGates => ['Core::V1::PodSchedulingGate'];

=attr schedulingGates

SchedulingGates is an opaque list of values that if specified will block scheduling the pod. If schedulingGates is not empty, the pod will stay in the SchedulingGated state and the scheduler will not attempt to schedule the pod.

SchedulingGates can only be set at pod creation time, and be removed only afterwards.

=cut

k8s securityContext => 'Core::V1::PodSecurityContext';

=attr securityContext

SecurityContext holds pod-level security attributes and common container settings. Optional: Defaults to empty.  See type description for default values of each field.

=cut

k8s serviceAccount => Str;

=attr serviceAccount

DeprecatedServiceAccount is a deprecated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead.

=cut

k8s serviceAccountName => Str;

=attr serviceAccountName

ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/

=cut

k8s setHostnameAsFQDN => Bool;

=attr setHostnameAsFQDN

If true the pod's hostname will be configured as the pod's FQDN, rather than the leaf name (the default). In Linux containers, this means setting the FQDN in the hostname field of the kernel (the nodename field of struct utsname). In Windows containers, this means setting the registry value of hostname for the registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters to FQDN. If a pod does not have FQDN, this has no effect. Default to false.

=cut

k8s shareProcessNamespace => Bool;

=attr shareProcessNamespace

Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false.

=cut

k8s subdomain => Str;

=attr subdomain

If specified, the fully qualified Pod hostname will be "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>". If not specified, the pod will not have a domainname at all.

=cut

k8s terminationGracePeriodSeconds => Int;

=attr terminationGracePeriodSeconds

Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.

=cut

k8s tolerations => ['Core::V1::Toleration'];

=attr tolerations

If specified, the pod's tolerations.

=cut

k8s topologySpreadConstraints => ['Core::V1::TopologySpreadConstraint'];

=attr topologySpreadConstraints

TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. All topologySpreadConstraints are ANDed.

=cut

k8s volumes => ['Core::V1::Volume'];

=attr volumes

List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes

=cut

1;
