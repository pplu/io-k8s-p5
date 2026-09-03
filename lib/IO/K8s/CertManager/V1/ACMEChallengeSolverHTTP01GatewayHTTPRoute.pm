package IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01GatewayHTTPRoute;
# ABSTRACT: The Gateway API is a sig-network community API that models service networking in Kubernetes (https://gateway-api.sigs.k8s.io/).
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s labels      => { Str => 1 };
k8s parentRefs  => ['+IO::K8s::CertManager::V1::ParentReference'];
k8s podTemplate => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressPodTemplate';
k8s serviceType => Str;

=attr labels

Custom labels that will be applied to HTTPRoutes created by cert-manager
while solving HTTP-01 challenges.

=cut

=attr parentRefs

When solving an HTTP-01 challenge, cert-manager creates an HTTPRoute.
cert-manager needs to know which parentRefs should be used when creating
the HTTPRoute. Usually, the parentRef references a Gateway. See:
https://gateway-api.sigs.k8s.io/api-types/httproute/#attaching-to-gateways

=cut

=attr podTemplate

Optional pod template used to configure the ACME challenge solver pods
used for HTTP01 challenges.

=cut

=attr serviceType

Optional service type for Kubernetes solver service. Supported values
are NodePort or ClusterIP. If unset, defaults to NodePort.

=cut

1;
