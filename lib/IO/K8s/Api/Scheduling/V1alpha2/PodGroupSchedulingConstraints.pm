package IO::K8s::Api::Scheduling::V1alpha2::PodGroupSchedulingConstraints;
# ABSTRACT: PodGroupSchedulingConstraints defines scheduling constraints (e.g. topology) for a PodGroup.
our $VERSION = '1.105';
use IO::K8s::Resource;

k8s topology => ['Scheduling::V1alpha2::TopologyConstraint'];

=attr topology

Topology defines the topology constraints for the pod group. Currently only a single topology constraint can be specified. This may change in the future.

=cut

1;
