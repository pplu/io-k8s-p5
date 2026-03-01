package IO::K8s::Api::Apps::V1::ReplicaSetSpec;
# ABSTRACT: ReplicaSetSpec is the specification of a ReplicaSet.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s minReadySeconds => Int;

=attr minReadySeconds

Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)

=cut

k8s replicas => Int;

=attr replicas

Replicas is the number of desired replicas. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#what-is-a-replicationcontroller

=cut

k8s selector => 'Meta::V1::LabelSelector', 'required';

=attr selector

Selector is a label query over pods that should match the replica count. Label keys and values that must match in order to be controlled by this replica set. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors

=cut

k8s template => 'Core::V1::PodTemplateSpec';

=attr template

Template is the object that describes the pod that will be created if insufficient replicas are detected. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template

=cut

1;
