package IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressTemplate;
# ABSTRACT: Optional ingress template used to configure the ACME challenge solver ingress used for HTTP01 challenges.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s metadata => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressObjectMeta';

=attr metadata

ObjectMeta overrides for the ingress used to solve HTTP01 challenges.
Only the 'labels' and 'annotations' fields may be set.
If labels or annotations overlap with in-built values, the values here
will override the in-built values.

=cut

1;
