package IO::K8s::Api::Lifecycle::V1alpha1::EvictionRequestTarget;
# ABSTRACT: EvictionRequestTarget contains a reference to an object that should be evicted.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s pod => 'Lifecycle::V1alpha1::EvictionRequestPodReference';

=attr pod

pod references a pod that is subject to eviction/termination. Pods that are part of a PodGroup (.spec.schedulingGroup is set) are not supported.

=cut

1;
