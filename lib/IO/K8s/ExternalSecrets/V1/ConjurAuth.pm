package IO::K8s::ExternalSecrets::V1::ConjurAuth;
# ABSTRACT: Defines authentication settings for connecting to Conjur.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s apikey => '+IO::K8s::ExternalSecrets::V1::ConjurAPIKey';
k8s cert   => '+IO::K8s::ExternalSecrets::V1::ConjurCert';
k8s jwt    => '+IO::K8s::ExternalSecrets::V1::ConjurJWT';

=attr apikey

Authenticates with Conjur using an API key.

=cut

=attr cert

Cert enables certificate-based authentication using a client certificate and key.

=cut

=attr jwt

Jwt enables JWT authentication using Kubernetes service account tokens.

=cut

1;
