package IO::K8s::Api::Scheduling::V1alpha3::PodGroupSchedulingPolicy;
# ABSTRACT: PodGroupSchedulingPolicy defines the scheduling configuration for a PodGroup. Exactly one policy must be set. The policy is chosen at creation time by setting either the Basic or Gang field. The PodGroup may not change policy after creation. Fields within chosen policy may be updated after creation when their individual fields allow it.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s basic => 'Scheduling::V1alpha3::BasicSchedulingPolicy';

=attr basic

basic specifies that the pods in this group should be scheduled using standard Kubernetes scheduling behavior. Setting this field at group creation time opts this group to basic scheduling; this field cannot be changed afterward.

=cut

k8s gang => 'Scheduling::V1alpha3::GangSchedulingPolicy';

=attr gang

gang specifies that the pods in this group should be scheduled using all-or-nothing semantics. Setting this field at group creation time opts this group to gang scheduling; this field cannot be set or unset afterward. The minCount field within Gang scheduling policy remains mutable after group creation.

=cut

1;
