package IO::K8s::Api::Core::V1::WeightedPodAffinityTerm;
# ABSTRACT: The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s podAffinityTerm => 'Core::V1::PodAffinityTerm', 'required';

=attr podAffinityTerm

Required. A pod affinity term, associated with the corresponding weight.

=cut

k8s weight => Int, 'required';

=attr weight

weight associated with matching the corresponding podAffinityTerm, in the range 1-100.

=cut

1;
