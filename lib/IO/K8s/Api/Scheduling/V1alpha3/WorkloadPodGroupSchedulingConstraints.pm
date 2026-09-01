package IO::K8s::Api::Scheduling::V1alpha3::WorkloadPodGroupSchedulingConstraints;
# ABSTRACT: WorkloadPodGroupSchedulingConstraints defines leaf-level scheduling constraints, such as topology.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s topology => ['Scheduling::V1alpha3::TopologyConstraint'];

=attr topology

topology specifies desired topological placements for all pods within the pod group. If unset, no topology placement is requested.

=cut

1;
