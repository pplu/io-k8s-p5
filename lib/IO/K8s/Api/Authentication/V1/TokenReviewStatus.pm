package IO::K8s::Api::Authentication::V1::TokenReviewStatus;
# ABSTRACT: TokenReviewStatus is the result of the token authentication request.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s audiences => [Str];

=attr audiences

Audiences are audience identifiers chosen by the authenticator that are compatible with both the TokenReview and token. An identifier is any identifier in the intersection of the TokenReviewSpec audiences and the token's audiences. A client of the TokenReview API that sets the spec.audiences field should validate that a compatible audience identifier is returned in the status.audiences field to ensure that the TokenReview server is audience aware. If a TokenReview returns an empty status.audience field where status.authenticated is "true", the token is valid against the audience of the Kubernetes API server.

=cut

k8s authenticated => Bool;

=attr authenticated

Authenticated indicates that the token was associated with a known user.

=cut

k8s error => Str;

=attr error

Error indicates that the token couldn't be checked

=cut

k8s user => 'Authentication::V1::UserInfo';

=attr user

User is the UserInfo associated with the provided token.

=cut

1;
