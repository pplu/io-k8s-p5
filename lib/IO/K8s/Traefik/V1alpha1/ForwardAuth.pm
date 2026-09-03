package IO::K8s::Traefik::V1alpha1::ForwardAuth;
# ABSTRACT: ForwardAuth holds the forward auth middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addAuthCookiesToResponse => [Str];
k8s address                  => Str;
k8s authRequestHeaders       => [Str];
k8s authResponseHeaders      => [Str];
k8s authResponseHeadersRegex => Str;
k8s authSigninURL            => Str;
k8s forwardBody              => Bool;
k8s headerField              => Str;
k8s maxBodySize              => Int;
k8s maxResponseBodySize      => Int;
k8s preserveLocationHeader   => Bool;
k8s preserveRequestMethod    => Bool;
k8s tls                      => '+IO::K8s::Traefik::V1alpha1::ClientTLSWithCAOptional';
k8s trustForwardHeader       => Bool;

=attr addAuthCookiesToResponse

AddAuthCookiesToResponse defines the list of cookies to copy from the authentication server response to the response.

=cut

=attr address

Address defines the authentication server address.

=cut

=attr authRequestHeaders

AuthRequestHeaders defines the list of the headers to copy from the request to the authentication server.
If not set or empty then all request headers are passed.

=cut

=attr authResponseHeaders

AuthResponseHeaders defines the list of headers to copy from the authentication server response and set on forwarded request, replacing any existing conflicting headers.

=cut

=attr authResponseHeadersRegex

AuthResponseHeadersRegex defines the regex to match headers to copy from the authentication server response and set on forwarded request, after stripping all headers that match the regex.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/forwardauth/#authresponseheadersregex

=cut

=attr authSigninURL

AuthSigninURL specifies the URL to redirect to when the authentication server returns 401 Unauthorized.

=cut

=attr forwardBody

ForwardBody defines whether to send the request body to the authentication server.

=cut

=attr headerField

HeaderField defines a header field to store the authenticated user.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/forwardauth/#headerfield

=cut

=attr maxBodySize

MaxBodySize defines the maximum body size in bytes allowed to be forwarded to the authentication server.

=cut

=attr maxResponseBodySize

MaxResponseBodySize defines the maximum body size in bytes allowed in the response from the authentication server.

=cut

=attr preserveLocationHeader

PreserveLocationHeader defines whether to forward the Location header to the client as is or prefix it with the domain name of the authentication server.

=cut

=attr preserveRequestMethod

PreserveRequestMethod defines whether to preserve the original request method while forwarding the request to the authentication server.

=cut

=attr tls

TLS defines the configuration used to secure the connection to the authentication server.

=cut

=attr trustForwardHeader

TrustForwardHeader defines whether to trust (ie: forward) all X-Forwarded-* headers.

Deprecated: Use forwardedHeaders.trustedIPs at the EntryPoint level instead, and set trustForwardHeader to true on this middleware.

=cut

1;
