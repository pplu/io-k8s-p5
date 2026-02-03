package IO::K8s::Api::Core::V1::ContainerStatus;
# ABSTRACT: ContainerStatus contains details for the current status of this container.

use IO::K8s::Resource;

k8s allocatedResources => { Str => 1 };

=attr allocatedResources

AllocatedResources represents the compute resources allocated for this container by the node. Kubelet sets this value to Container.Resources.Requests upon successful pod admission and after successfully admitting desired pod resize.

=cut

k8s allocatedResourcesStatus => ['Core::V1::ResourceStatus'];

=attr allocatedResourcesStatus

AllocatedResourcesStatus represents the status of various resources allocated for this Pod.

=cut

k8s containerID => Str;

=attr containerID

ContainerID is the ID of the container in the format '<type>://<container_id>'. Where type is a container runtime identifier, returned from Version call of CRI API (for example "containerd").

=cut

k8s image => Str, 'required';

=attr image

Image is the name of container image that the container is running. The container image may not match the image used in the PodSpec, as it may have been resolved by the runtime. More info: https://kubernetes.io/docs/concepts/containers/images.

=cut

k8s imageID => Str, 'required';

=attr imageID

ImageID is the image ID of the container's image. The image ID may not match the image ID of the image used in the PodSpec, as it may have been resolved by the runtime.

=cut

k8s lastState => 'Core::V1::ContainerState';

=attr lastState

LastTerminationState holds the last termination state of the container to help debug container crashes and restarts. This field is not populated if the container is still running and RestartCount is 0.

=cut

k8s name => Str, 'required';

=attr name

Name is a DNS_LABEL representing the unique name of the container. Each container in a pod must have a unique name across all container types. Cannot be updated.

=cut

k8s ready => Bool, 'required';

=attr ready

Ready specifies whether the container is currently passing its readiness check. The value will change as readiness probes keep executing. If no readiness probes are specified, this field defaults to true once the container is fully started (see Started field).

The value is typically used to determine whether a container is ready to accept traffic.

=cut

k8s resources => 'Core::V1::ResourceRequirements';

=attr resources

Resources represents the compute resource requests and limits that have been successfully enacted on the running container after it has been started or has been successfully resized.

=cut

k8s restartCount => Int, 'required';

=attr restartCount

RestartCount holds the number of times the container has been restarted. Kubelet makes an effort to always increment the value, but there are cases when the state may be lost due to node restarts and then the value may be reset to 0. The value is never negative.

=cut

k8s started => Bool;

=attr started

Started indicates whether the container has finished its postStart lifecycle hook and passed its startup probe. Initialized as false, becomes true after startupProbe is considered successful. Resets to false when the container is restarted, or if kubelet loses state temporarily. In both cases, startup probes will run again. Is always true when no startupProbe is defined and container is running and has passed the postStart lifecycle hook. The null value must be treated the same as false.

=cut

k8s state => 'Core::V1::ContainerState';

=attr state

State holds details about the container's current condition.

=cut

k8s user => 'Core::V1::ContainerUser';

=attr user

User represents user identity information initially attached to the first process of the container

=cut

k8s volumeMounts => ['Core::V1::VolumeMountStatus'];

=attr volumeMounts

Status of volume mounts.

=cut

1;
