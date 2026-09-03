package IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressPodObjectMeta;
# ABSTRACT: ObjectMeta overrides for the pod used to solve HTTP01 challenges.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s annotations => { Str => 1 };
k8s labels      => { Str => 1 };

=attr annotations

Annotations that should be added to the created ACME HTTP01 solver pods.

=cut

=attr labels

Labels that should be added to the created ACME HTTP01 solver pods.

=cut

1;
