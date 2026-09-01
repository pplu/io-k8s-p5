package IO::K8s::Api::Scheduling::V1alpha3::WorkloadPodGroupDisruptionMode;
# ABSTRACT: WorkloadPodGroupDisruptionMode defines how individual pods within a group can be disrupted. Exactly one mode must be set.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s all => 'Scheduling::V1alpha3::WorkloadPodGroupAllDisruptionMode';

=attr all

all specifies that all pods in the group must be disrupted together.

=cut

k8s single => 'Scheduling::V1alpha3::WorkloadPodGroupSingleDisruptionMode';

=attr single

single specifies that pods can be disrupted independently from each other.

=cut

1;
