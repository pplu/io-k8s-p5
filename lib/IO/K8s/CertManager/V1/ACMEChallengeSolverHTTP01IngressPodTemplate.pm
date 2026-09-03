package IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressPodTemplate;
# ABSTRACT: Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s metadata => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressPodObjectMeta';
k8s spec     => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressPodSpec';

=attr metadata

ObjectMeta overrides for the pod used to solve HTTP01 challenges.
Only the 'labels' and 'annotations' fields may be set.
If labels or annotations overlap with in-built values, the values here
will override the in-built values.

=cut

=attr spec

PodSpec defines overrides for the HTTP01 challenge solver pod.
Check ACMEChallengeSolverHTTP01IngressPodSpec to find out currently supported fields.
All other fields will be ignored.

=cut

1;
