package IO::K8s::Api::Authentication::V1::TokenRequestStatus;
# ABSTRACT: TokenRequestStatus is the result of a token request.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s expirationTimestamp => Time, 'required';

=attr expirationTimestamp

ExpirationTimestamp is the time of expiration of the returned token.

=cut

k8s token => Str, 'required';

=attr token

Token is the opaque bearer token.

=cut

1;
