package IO::K8s::ExternalSecrets::V1::ConjurJWT;
# ABSTRACT: Jwt enables JWT authentication using Kubernetes service account tokens.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s account           => Str, { required => 'schema' };
k8s hostId            => Str;
k8s secretRef         => '+IO::K8s::ExternalSecrets::V1::SecretKeySelector';
k8s serviceAccountRef => '+IO::K8s::ExternalSecrets::V1::ServiceAccountSelector';
k8s serviceID         => Str, { required => 'schema' };

=attr account

Account is the Conjur organization account name.

=cut

=attr hostId

Optional HostID for JWT authentication. This may be used depending
on how the Conjur JWT authenticator policy is configured.

=cut

=attr secretRef

Optional SecretRef that refers to a key in a Secret resource containing JWT token to
authenticate with Conjur using the JWT authentication method.

=cut

=attr serviceAccountRef

Optional ServiceAccountRef specifies the Kubernetes service account for which to request
a token for with the `TokenRequest` API.

=cut

=attr serviceID

The conjur authn jwt webservice id

=cut

1;
