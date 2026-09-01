package IO::K8s::Api::Core::V1::NodeAllocatableOverheadResources;
# ABSTRACT: NodeAllocatableOverheadResources describes auxiliary overhead resource allocations.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

Name is the name of the resource (e.g., cpu, memory).

=cut

k8s perContainer => Quantity;

=attr perContainer

PerContainer is the variable overhead quantity applied for each container referencing the claim. The container references are recorded in `nodeAllocatableResourceClaimStatuses.containers`. The total overhead quantity allocated for the claim is computed as: Quantity = PerPod + (PerContainer * NumReferences) Kubelet accounts for this overhead in cgroups: - Pod-level cgroup (requests and limits): Kubelet adds PerPod + (PerContainer * NumReferences). - Container-level cgroup (limits only): Kubelet adds PerPod + PerContainer for each referencing container. This allows any single container to access the pod-level overhead, while the parent cgroup caps the total usage to account for PerPod exactly once. At least one of PerPod or PerContainer must be specified. Specifying neither is an invalid configuration.

=cut

k8s perPod => Quantity;

=attr perPod

PerPod is the flat overhead quantity allocated per pod. Adding to each container limit allows individual containers to utilize the overhead, while the parent pod-level cgroup limit caps the total usage at the pod boundary where the overhead is accounted for exactly once. At least one of PerPod or PerContainer must be specified. Specifying neither is an invalid configuration.

=cut

1;
