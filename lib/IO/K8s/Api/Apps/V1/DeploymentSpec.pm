package IO::K8s::Api::Apps::V1::DeploymentSpec;
# ABSTRACT: DeploymentSpec is the specification of the desired behavior of the Deployment.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s minReadySeconds => Int;

=attr minReadySeconds

Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready)

=cut

k8s paused => Bool;

=attr paused

Indicates that the deployment is paused.

=cut

k8s progressDeadlineSeconds => Int;

=attr progressDeadlineSeconds

The maximum time in seconds for a deployment to make progress before it is considered to be failed. The deployment controller will continue to process failed deployments and a condition with a ProgressDeadlineExceeded reason will be surfaced in the deployment status. Note that progress will not be estimated during the time a deployment is paused. Defaults to 600s.

=cut

k8s replicas => Int;

=attr replicas

Number of desired pods. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.

=cut

k8s revisionHistoryLimit => Int;

=attr revisionHistoryLimit

The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. Defaults to 10.

=cut

k8s selector => 'Meta::V1::LabelSelector', 'required';

=attr selector

Label selector for pods. Existing ReplicaSets whose pods are selected by this will be the ones affected by this deployment. It must match the pod template's labels.

=cut

k8s strategy => 'Apps::V1::DeploymentStrategy';

=attr strategy

The deployment strategy to use to replace existing pods with new ones.

=cut

k8s template => 'Core::V1::PodTemplateSpec', 'required';

=attr template

Template describes the pods that will be created. The only allowed template.spec.restartPolicy value is "Always".

=cut

1;
