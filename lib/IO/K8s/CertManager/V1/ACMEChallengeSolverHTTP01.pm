package IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01;
# ABSTRACT: Configures cert-manager to attempt to complete authorizations by performing the HTTP01 challenge flow.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s gatewayHTTPRoute => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01GatewayHTTPRoute';
k8s ingress          => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01Ingress';

=attr gatewayHTTPRoute

The Gateway API is a sig-network community API that models service networking
in Kubernetes (https://gateway-api.sigs.k8s.io/). The Gateway solver will
create HTTPRoutes with the specified labels in the same namespace as the challenge.
This solver is experimental, and fields / behaviour may change in the future.

=cut

=attr ingress

The ingress based HTTP01 challenge solver will solve challenges by
creating or modifying Ingress resources in order to route requests for
'/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are
provisioned by cert-manager for each Challenge to be completed.

=cut

1;
