package IO::K8s::Api::Core::V1::NodeAllocatableMappedResources;
# ABSTRACT: NodeAllocatableMappedResources describes mapped node allocatable resource allocations.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name is the name of the resource (e.g., cpu, memory).

=cut

k8s quantity => Quantity, 'required';

=attr quantity

Quantity is the total node allocatable resource capacity allocated for the claim. This claim's allocated devices is shared by all the containers referencing the claim. Kubelet adds this value to both requests and limits at the pod-level cgroup, and to limits at the container-level cgroup for each container referencing the claim.

=cut

1;
