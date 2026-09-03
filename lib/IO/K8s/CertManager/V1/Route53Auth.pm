package IO::K8s::CertManager::V1::Route53Auth;
# ABSTRACT: Auth configures how cert-manager authenticates.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s kubernetes => '+IO::K8s::CertManager::V1::Route53KubernetesAuth', { required => 'schema' };

=attr kubernetes

Kubernetes authenticates with Route53 using AssumeRoleWithWebIdentity
by passing a bound ServiceAccount token.

=cut

1;
