package IO::K8s::Api::Core::V1::VolumeHealthStatus;
# ABSTRACT: VolumeHealthStatus contains health information for a volume reported by the CSI controller plugin.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s healthConditions => ['Core::V1::VolumeHealthCondition'];

=attr healthConditions

conditions is the set of adverse conditions reported by the CSI controller plugin. An empty list means no adverse condition. At most 16 conditions may be reported.

=cut

k8s lastTransitionTime => Time;

=attr lastTransitionTime

lastTransitionTime is when the current set of conditions first appeared.

=cut

1;
