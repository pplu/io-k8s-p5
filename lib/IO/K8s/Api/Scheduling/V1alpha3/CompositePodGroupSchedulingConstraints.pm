package IO::K8s::Api::Scheduling::V1alpha3::CompositePodGroupSchedulingConstraints;
# ABSTRACT: CompositePodGroupSchedulingConstraints defines scheduling constraints (e.g. topology) for a CompositePodGroup.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s topology => ['Scheduling::V1alpha3::TopologyConstraint'];

=attr topology

topology defines the topology constraints for the composite pod group. Currently only a single topology constraint can be specified. This may change in the future.

=cut

1;
