package IO::K8s::Api::Authentication::V1::TokenRequest;
# ABSTRACT: TokenRequest requests a token for a given service account.
our $VERSION = '1.007';
use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=description

TokenRequest requests a token for a given service account.

This is a Kubernetes API object. See L<IO::K8s::Role::APIObject> for
C<metadata>, C<api_version()>, and C<kind()>.


=cut

k8s spec => 'Authentication::V1::TokenRequestSpec', 'required';

=attr spec

Spec holds information about the request being evaluated


=cut

k8s status => 'Authentication::V1::TokenRequestStatus';

=attr status

Status is filled in by the server and indicates whether the token can be authenticated.


=cut
=seealso

L<https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#tokenrequest-v1-authentication.k8s.io>


=cut
1;
