package IO::K8s::Api::Core::V1::EphemeralContainer;
# ABSTRACT: An EphemeralContainer is a temporary container that you may add to an existing Pod for user-initiated activities such as debugging. Ephemeral containers have no resource or scheduling guarantees, and they will not be restarted when they exit or when a Pod is removed or restarted. The kubelet may evict a Pod if an ephemeral container causes the Pod to exceed its resource allocation. To add an ephemeral container, use the ephemeralcontainers subresource of an existing Pod. Ephemeral containers may not be removed or restarted.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s args => [Str];

=attr args

Arguments to the entrypoint. The image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell

=cut

k8s command => [Str];

=attr command

Entrypoint array. Not executed within a shell. The image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell

=cut

k8s env => ['Core::V1::EnvVar'];

=attr env

List of environment variables to set in the container. Cannot be updated.

=cut

k8s envFrom => ['Core::V1::EnvFromSource'];

=attr envFrom

List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated.

=cut

k8s image => Str;

=attr image

Container image name. More info: https://kubernetes.io/docs/concepts/containers/images

=cut

k8s imagePullPolicy => Str;

=attr imagePullPolicy

Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images

=cut

k8s lifecycle => 'Core::V1::Lifecycle';

=attr lifecycle

Lifecycle is not allowed for ephemeral containers.

=cut

k8s livenessProbe => 'Core::V1::Probe';

=attr livenessProbe

Probes are not allowed for ephemeral containers.

=cut

k8s name => Str, 'required';

=attr name

Name of the ephemeral container specified as a DNS_LABEL. This name must be unique among all containers, init containers and ephemeral containers.

=cut

k8s ports => ['Core::V1::ContainerPort'];

=attr ports

Ports are not allowed for ephemeral containers.

=cut

k8s readinessProbe => 'Core::V1::Probe';

=attr readinessProbe

Probes are not allowed for ephemeral containers.

=cut

k8s resizePolicy => ['Core::V1::ContainerResizePolicy'];

=attr resizePolicy

Resources resize policy for the container.

=cut

k8s resources => 'Core::V1::ResourceRequirements';

=attr resources

Resources are not allowed for ephemeral containers. Ephemeral containers use spare resources already allocated to the pod.

=cut

k8s restartPolicy => Str;

=attr restartPolicy

Restart policy for the container to manage the restart behavior of each container within a pod. This may only be set for init containers. You cannot set this field on ephemeral containers.

=cut

k8s securityContext => 'Core::V1::SecurityContext';

=attr securityContext

Optional: SecurityContext defines the security options the ephemeral container should be run with. If set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.

=cut

k8s startupProbe => 'Core::V1::Probe';

=attr startupProbe

Probes are not allowed for ephemeral containers.

=cut

k8s stdin => Bool;

=attr stdin

Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false.

=cut

k8s stdinOnce => Bool;

=attr stdinOnce

Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false

=cut

k8s targetContainerName => Str;

=attr targetContainerName

If set, the name of the container from PodSpec that this ephemeral container targets. The ephemeral container will be run in the namespaces (IPC, PID, etc) of this container. If not set then the ephemeral container uses the namespaces configured in the Pod spec.

The container runtime must implement support for this feature. If the runtime does not support namespace targeting then the result of setting this field is undefined.

=cut

k8s terminationMessagePath => Str;

=attr terminationMessagePath

Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated.

=cut

k8s terminationMessagePolicy => Str;

=attr terminationMessagePolicy

Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated.

=cut

k8s tty => Bool;

=attr tty

Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false.

=cut

k8s volumeDevices => ['Core::V1::VolumeDevice'];

=attr volumeDevices

volumeDevices is the list of block devices to be used by the container.

=cut

k8s volumeMounts => ['Core::V1::VolumeMount'];

=attr volumeMounts

Pod volumes to mount into the container's filesystem. Subpath mounts are not allowed for ephemeral containers. Cannot be updated.

=cut

k8s workingDir => Str;

=attr workingDir

Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated.

=cut

1;
