package IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01Ingress;
# ABSTRACT: The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s class            => Str;
k8s ingressClassName => Str;
k8s ingressTemplate  => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressTemplate';
k8s name             => Str;
k8s podTemplate      => '+IO::K8s::CertManager::V1::ACMEChallengeSolverHTTP01IngressPodTemplate';
k8s serviceType      => Str;

=attr class

This field configures the annotation `kubernetes.io/ingress.class` when
creating Ingress resources to solve ACME challenges that use this
challenge solver. Only one of `class`, `name` or `ingressClassName` may
be specified.

=cut

=attr ingressClassName

This field configures the field `ingressClassName` on the created Ingress
resources used to solve ACME challenges that use this challenge solver.
This is the recommended way of configuring the ingress class. Only one of
`class`, `name` or `ingressClassName` may be specified.

=cut

=attr ingressTemplate

Optional ingress template used to configure the ACME challenge solver
ingress used for HTTP01 challenges.

=cut

=attr name

The name of the ingress resource that should have ACME challenge solving
routes inserted into it in order to solve HTTP01 challenges.
This is typically used in conjunction with ingress controllers like
ingress-gce, which maintains a 1:1 mapping between external IPs and
ingress resources. Only one of `class`, `name` or `ingressClassName` may
be specified.

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
