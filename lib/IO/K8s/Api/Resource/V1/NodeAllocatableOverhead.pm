package IO::K8s::Api::Resource::V1::NodeAllocatableOverhead;
# ABSTRACT: NodeAllocatableOverhead defines auxiliary resource overheads incurred when allocating a device. Overheads can be specified as a fixed cost per pod referencing the claim, a variable cost per container reference, or both. Kubelet accounts for this overhead by adding it to both the pod-level and container-level cgroups of referencing containers.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s perContainer => Quantity;

=attr perContainer

PerContainer is applied per container reference to the claim. This models overhead scaling linearly with the number of containers actively using the device. When both PerPod and PerContainer are specified, the total overhead allocated for each pod referencing the claim is computed as: Quantity = PerPod + (PerContainer * NumReferences) Kubelet accounts for this overhead in cgroups: - Pod-level cgroup (requests and limits): Kubelet adds PerPod + (PerContainer * NumReferences). - Container-level cgroup (limits only): Kubelet adds PerPod + PerContainer for each referencing container. This allows any single container to access the pod-level overhead, while the parent cgroup caps the total usage to account for PerPod exactly once.

=cut

k8s perPod => Quantity;

=attr perPod

PerPod is overhead applied once per pod referencing the claim on this node. This is a flat overhead incurred for every pod referencing the claim.

=cut

1;
