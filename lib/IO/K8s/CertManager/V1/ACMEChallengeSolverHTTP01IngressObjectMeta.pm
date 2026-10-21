package IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressObjectMeta;
# ABSTRACT: ObjectMeta overrides for the ingress used to solve HTTP01 challenges.
our $VERSION = '1.112';
use IO::K8s::Resource;

k8s annotations => HashRef[Str];
k8s labels      => HashRef[Str];

=attr annotations

Annotations that should be added to the created ACME HTTP01 solver ingress.

=cut

=attr labels

Labels that should be added to the created ACME HTTP01 solver ingress.

=cut

1;
