package IO::K8s::Api::Authentication::V1::TokenRequest;
# ABSTRACT: TokenRequest requests a token for a given service account.

use IO::K8s::APIObject;
with 'IO::K8s::Role::Namespaced';

=head1 DESCRIPTION

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

1;
