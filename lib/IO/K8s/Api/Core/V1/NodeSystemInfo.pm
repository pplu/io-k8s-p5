package IO::K8s::Api::Core::V1::NodeSystemInfo;
# ABSTRACT: NodeSystemInfo is a set of ids/uuids to uniquely identify the node.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s architecture => Str, 'required';

=attr architecture

The Architecture reported by the node

=cut

k8s bootID => Str, 'required';

=attr bootID

Boot ID reported by the node.

=cut

k8s containerRuntimeVersion => Str, 'required';

=attr containerRuntimeVersion

ContainerRuntime Version reported by the node through runtime remote API (e.g. containerd://1.4.2).

=cut

k8s kernelVersion => Str, 'required';

=attr kernelVersion

Kernel Version reported by the node from 'uname -r' (e.g. 3.16.0-0.bpo.4-amd64).

=cut

k8s kubeProxyVersion => Str, 'required';

=attr kubeProxyVersion

Deprecated: KubeProxy Version reported by the node.

=cut

k8s kubeletVersion => Str, 'required';

=attr kubeletVersion

Kubelet Version reported by the node.

=cut

k8s machineID => Str, 'required';

=attr machineID

MachineID reported by the node. For unique machine identification in the cluster this field is preferred. Learn more from man(5) machine-id: http://man7.org/linux/man-pages/man5/machine-id.5.html

=cut

k8s operatingSystem => Str, 'required';

=attr operatingSystem

The Operating System reported by the node

=cut

k8s osImage => Str, 'required';

=attr osImage

OS Image reported by the node from /etc/os-release (e.g. Debian GNU/Linux 7 (wheezy)).

=cut

k8s systemUUID => Str, 'required';

=attr systemUUID

SystemUUID reported by the node. For unique machine identification MachineID is preferred. This field is specific to Red Hat hosts https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/rhsm/uuid

=cut

1;
