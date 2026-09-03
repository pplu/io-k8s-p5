package IO::K8s::CertManager::V1::Route53KubernetesAuth;
# ABSTRACT: Kubernetes authenticates with Route53 using AssumeRoleWithWebIdentity by passing a bound ServiceAccount token.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s serviceAccountRef => '+IO::K8s::CertManager::V1::ServiceAccountRef', { required => 'schema' };

=attr serviceAccountRef

A reference to a service account that will be used to request a bound
token (also known as "projected token"). To use this field, you must
configure an RBAC rule to let cert-manager request a token.

=cut

1;
