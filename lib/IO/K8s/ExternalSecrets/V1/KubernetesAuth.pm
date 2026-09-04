package IO::K8s::ExternalSecrets::V1::KubernetesAuth;
# ABSTRACT: Auth configures how secret-manager authenticates with a Kubernetes instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s cert           => '+IO::K8s::ExternalSecrets::V1::CertAuth';
k8s serviceAccount => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';
k8s token          => '+IO::K8s::ExternalSecrets::V1::TokenAuth';

=attr cert

has both clientCert and clientKey as secretKeySelector

=cut

=attr serviceAccount

points to a service account that should be used for authentication

=cut

=attr token

use static token to authenticate with

=cut

1;
