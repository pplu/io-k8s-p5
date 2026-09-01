package IO::K8s::Api::Scheduling::V1beta1::TopologyConstraint;
# ABSTRACT: TopologyConstraint defines a topology constraint for a PodGroup.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s key => Str, 'required';

=attr key

key specifies the key of the node label representing the topology domain. All pods within the PodGroup must be colocated within the same domain instance. Different PodGroups can land on different domain instances even if they derive from the same PodGroupTemplate. Examples: "topology.kubernetes.io/rack"

=cut

1;
