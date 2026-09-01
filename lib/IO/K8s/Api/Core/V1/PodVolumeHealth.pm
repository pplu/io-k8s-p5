package IO::K8s::Api::Core::V1::PodVolumeHealth;
# ABSTRACT: PodVolumeHealth contains health information for a volume used by a pod, reported by the CSI node plugin via the kubelet.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s healthConditions => ['Core::V1::VolumeHealthCondition'];

=attr healthConditions

conditions is the set of adverse conditions reported by the CSI node plugin for this volume on this node. At most 16 conditions may be reported.

=cut

k8s lastTransitionTime => Time;

=attr lastTransitionTime

lastTransitionTime is when the current set of conditions first appeared.

=cut

k8s name => Str, 'required';

=attr name

name matches an entry in pod.spec.volumes.

=cut

1;
