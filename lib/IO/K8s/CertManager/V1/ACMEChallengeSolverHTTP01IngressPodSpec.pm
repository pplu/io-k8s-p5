package IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressPodSpec;
# ABSTRACT: PodSpec defines overrides for the HTTP01 challenge solver pod.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s affinity           => 'Core::V1::Affinity';
k8s imagePullSecrets   => ['+IO::K8s::CertManager::V1::LocalObjectReference'];
k8s nodeSelector       => { Str => 1 };
k8s priorityClassName  => Str;
k8s resources          => 'Core::V1::VolumeResourceRequirements';
k8s securityContext    => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressPodSecurityContext';
k8s serviceAccountName => Str;
k8s tolerations        => ['Core::V1::Toleration'];

=attr affinity

If specified, the pod's scheduling constraints

=cut

=attr imagePullSecrets

If specified, the pod's imagePullSecrets

=cut

=attr nodeSelector

NodeSelector is a selector which must be true for the pod to fit on a node.
Selector which must match a node's labels for the pod to be scheduled on that node.
More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/

=cut

=attr priorityClassName

If specified, the pod's priorityClassName.

=cut

=attr resources

If specified, the pod's resource requirements.
These values override the global resource configuration flags.
Note that when only specifying resource limits, ensure they are greater than or equal
to the corresponding global resource requests configured via controller flags
(--acme-http01-solver-resource-request-cpu, --acme-http01-solver-resource-request-memory).
Kubernetes will reject pod creation if limits are lower than requests, causing challenge failures.

=cut

=attr securityContext

If specified, the pod's security context

=cut

=attr serviceAccountName

If specified, the pod's service account

=cut

=attr tolerations

If specified, the pod's tolerations.

=cut

1;
