package IO::K8s::Api::Apps::V1::DaemonSetSpec;
# ABSTRACT: DaemonSetSpec is the specification of a daemon set.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s minReadySeconds => Int;

=attr minReadySeconds

The minimum number of seconds for which a newly created DaemonSet pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready).

=cut

k8s revisionHistoryLimit => Int;

=attr revisionHistoryLimit

The number of old history to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.

=cut

k8s selector => 'Meta::V1::LabelSelector', 'required';

=attr selector

A label query over pods that are managed by the daemon set. Must match in order to be controlled. It must match the pod template's labels. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors

=cut

k8s template => 'Core::V1::PodTemplateSpec', 'required';

=attr template

An object that describes the pod that will be created. The DaemonSet will create exactly one copy of this pod on every node that matches the template's node selector (or on every node if no node selector is specified). The only allowed template.spec.restartPolicy value is "Always". More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#pod-template

=cut

k8s updateStrategy => 'Apps::V1::DaemonSetUpdateStrategy';

=attr updateStrategy

An update strategy to replace existing DaemonSet pods with new pods.

=cut

1;
