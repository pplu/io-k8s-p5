package IO::K8s::Api::Core::V1::NodeFeatures;
# ABSTRACT: NodeFeatures describes the set of features implemented by the CRI implementation. The features contained in the NodeFeatures should depend only on the cri implementation independent of runtime handlers.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s supplementalGroupsPolicy => Bool;

=attr supplementalGroupsPolicy

SupplementalGroupsPolicy is set to true if the runtime supports SupplementalGroupsPolicy and ContainerUser.

=cut

1;
