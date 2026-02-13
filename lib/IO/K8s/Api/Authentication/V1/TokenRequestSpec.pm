package IO::K8s::Api::Authentication::V1::TokenRequestSpec;
# ABSTRACT: TokenRequestSpec contains client provided parameters of a token request.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s audiences => [Str], 'required';

=attr audiences

Audiences are the intendend audiences of the token. A recipient of a token must identify themself with an identifier in the list of audiences of the token, and otherwise should reject the token. A token issued for multiple audiences may be used to authenticate against any of the audiences listed but implies a high degree of trust between the target audiences.

=cut

k8s boundObjectRef => 'Authentication::V1::BoundObjectReference';

=attr boundObjectRef

BoundObjectRef is a reference to an object that the token will be bound to. The token will only be valid for as long as the bound object exists. NOTE: The API server's TokenReview endpoint will validate the BoundObjectRef, but other audiences may not. Keep ExpirationSeconds small if you want prompt revocation.

=cut

k8s expirationSeconds => Int;

=attr expirationSeconds

ExpirationSeconds is the requested duration of validity of the request. The token issuer may return a token with a different validity duration so a client needs to check the 'expiration' field in a response.

=cut

1;
