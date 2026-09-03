package IO::K8s::Traefik::V1alpha1::MiddlewareSpec;
# ABSTRACT: MiddlewareSpec defines the desired state of a Middleware.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addPrefix         => '+IO::K8s::Traefik::V1alpha1::AddPrefix';
k8s basicAuth         => '+IO::K8s::Traefik::V1alpha1::BasicAuth';
k8s buffering         => '+IO::K8s::Traefik::V1alpha1::Buffering';
k8s chain             => '+IO::K8s::Traefik::V1alpha1::Chain';
k8s circuitBreaker    => '+IO::K8s::Traefik::V1alpha1::CircuitBreaker';
k8s compress          => '+IO::K8s::Traefik::V1alpha1::Compress';
k8s contentType       => '+IO::K8s::Traefik::V1alpha1::ContentType';
k8s digestAuth        => '+IO::K8s::Traefik::V1alpha1::DigestAuth';
k8s encodedCharacters => '+IO::K8s::Traefik::V1alpha1::EncodedCharacters';
k8s errors            => '+IO::K8s::Traefik::V1alpha1::ErrorPage';
k8s forwardAuth       => '+IO::K8s::Traefik::V1alpha1::ForwardAuth';
k8s grpcWeb           => '+IO::K8s::Traefik::V1alpha1::GrpcWeb';
k8s headers           => '+IO::K8s::Traefik::V1alpha1::Headers';
k8s inFlightReq       => '+IO::K8s::Traefik::V1alpha1::InFlightReq';
k8s ipAllowList       => '+IO::K8s::Traefik::V1alpha1::IPAllowList';
k8s ipWhiteList       => '+IO::K8s::Traefik::V1alpha1::IPWhiteList';
k8s passTLSClientCert => '+IO::K8s::Traefik::V1alpha1::PassTLSClientCert';
k8s plugin            => { Str => 1 };
k8s rateLimit         => '+IO::K8s::Traefik::V1alpha1::RateLimit';
k8s redirectRegex     => '+IO::K8s::Traefik::V1alpha1::RedirectRegex';
k8s redirectScheme    => '+IO::K8s::Traefik::V1alpha1::RedirectScheme';
k8s replacePath       => '+IO::K8s::Traefik::V1alpha1::ReplacePath';
k8s replacePathRegex  => '+IO::K8s::Traefik::V1alpha1::ReplacePathRegex';
k8s retry             => '+IO::K8s::Traefik::V1alpha1::Retry';
k8s stripPrefix       => '+IO::K8s::Traefik::V1alpha1::StripPrefix';
k8s stripPrefixRegex  => '+IO::K8s::Traefik::V1alpha1::StripPrefixRegex';

=attr addPrefix

AddPrefix holds the add prefix middleware configuration.
This middleware updates the path of a request before forwarding it.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/addprefix/

=cut

=attr basicAuth

BasicAuth holds the basic auth middleware configuration.
This middleware restricts access to your services to known users.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/basicauth/

=cut

=attr buffering

Buffering holds the buffering middleware configuration.
This middleware retries or limits the size of requests that can be forwarded to backends.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/buffering/#maxrequestbodybytes

=cut

=attr chain

Chain holds the configuration of the chain middleware.
This middleware enables to define reusable combinations of other pieces of middleware.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/chain/

=cut

=attr circuitBreaker

CircuitBreaker holds the circuit breaker configuration.

=cut

=attr compress

Compress holds the compress middleware configuration.
This middleware compresses responses before sending them to the client, using gzip, brotli, or zstd compression.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/compress/

=cut

=attr contentType

ContentType holds the content-type middleware configuration.
This middleware exists to enable the correct behavior until at least the default one can be changed in a future version.

=cut

=attr digestAuth

DigestAuth holds the digest auth middleware configuration.
This middleware restricts access to your services to known users.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/digestauth/

=cut

=attr encodedCharacters

EncodedCharacters configures which encoded characters are allowed in the request path.

=cut

=attr errors

ErrorPage holds the custom error middleware configuration.
This middleware returns a custom page in lieu of the default, according to configured ranges of HTTP Status codes.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/errorpages/

=cut

=attr forwardAuth

ForwardAuth holds the forward auth middleware configuration.
This middleware delegates the request authentication to a Service.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/forwardauth/

=cut

=attr grpcWeb

GrpcWeb holds the gRPC web middleware configuration.
This middleware converts a gRPC web request to an HTTP/2 gRPC request.

=cut

=attr headers

Headers holds the headers middleware configuration.
This middleware manages the requests and responses headers.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/headers/#customrequestheaders

=cut

=attr inFlightReq

InFlightReq holds the in-flight request middleware configuration.
This middleware limits the number of requests being processed and served concurrently.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/inflightreq/

=cut

=attr ipAllowList

IPAllowList holds the IP allowlist middleware configuration.
This middleware limits allowed requests based on the client IP.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/ipallowlist/

=cut

=attr ipWhiteList

Deprecated: please use IPAllowList instead.

=cut

=attr passTLSClientCert

PassTLSClientCert holds the pass TLS client cert middleware configuration.
This middleware adds the selected data from the passed client TLS certificate to a header.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/passtlsclientcert/

=cut

=attr plugin

Plugin defines the middleware plugin configuration.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/overview/#community-middlewares

=cut

=attr rateLimit

RateLimit holds the rate limit configuration.
This middleware ensures that services will receive a fair amount of requests, and allows one to define what fair is.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/ratelimit/

=cut

=attr redirectRegex

RedirectRegex holds the redirect regex middleware configuration.
This middleware redirects a request using regex matching and replacement.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/redirectregex/#regex

=cut

=attr redirectScheme

RedirectScheme holds the redirect scheme middleware configuration.
This middleware redirects requests from a scheme/port to another.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/redirectscheme/

=cut

=attr replacePath

ReplacePath holds the replace path middleware configuration.
This middleware replaces the path of the request URL and store the original path in an X-Replaced-Path header.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/replacepath/

=cut

=attr replacePathRegex

ReplacePathRegex holds the replace path regex middleware configuration.
This middleware replaces the path of a URL using regex matching and replacement.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/replacepathregex/

=cut

=attr retry

Retry holds the retry middleware configuration.
This middleware reissues requests a given number of times to a backend server if that server does not reply.
As soon as the server answers, the middleware stops retrying, regardless of the response status.
More info: https://doc.traefik.io/traefik/v3.7/reference/routing-configuration/http/middlewares/retry/

=cut

=attr stripPrefix

StripPrefix holds the strip prefix middleware configuration.
This middleware removes the specified prefixes from the URL path.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/stripprefix/

=cut

=attr stripPrefixRegex

StripPrefixRegex holds the strip prefix regex middleware configuration.
This middleware removes the matching prefixes from the URL path.
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/stripprefixregex/

=cut

1;
