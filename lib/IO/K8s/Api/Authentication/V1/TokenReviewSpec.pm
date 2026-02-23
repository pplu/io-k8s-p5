package IO::K8s::Api::Authentication::V1::TokenReviewSpec;
# ABSTRACT: TokenReviewSpec is a description of the token authentication request.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s audiences => [Str];

=attr audiences

Audiences is a list of the identifiers that the resource server presented with the token identifies as. Audience-aware token authenticators will verify that the token was intended for at least one of the audiences in this list. If no audiences are provided, the audience will default to the audience of the Kubernetes apiserver.

=cut

k8s token => Str;

=attr token

Token is the opaque bearer token.

=cut

1;
