package IO::K8s::Traefik::V1alpha1::Buffering;
# ABSTRACT: Buffering holds the buffering middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s maxRequestBodyBytes  => Int;
k8s maxResponseBodyBytes => Int;
k8s memRequestBodyBytes  => Int;
k8s memResponseBodyBytes => Int;
k8s retryExpression      => Str;

=attr maxRequestBodyBytes

MaxRequestBodyBytes defines the maximum allowed body size for the request (in bytes).
If the request exceeds the allowed size, it is not forwarded to the service, and the client gets a 413 (Request Entity Too Large) response.
Default: 0 (no maximum).

=cut

=attr maxResponseBodyBytes

MaxResponseBodyBytes defines the maximum allowed response size from the service (in bytes).
If the response exceeds the allowed size, it is not forwarded to the client. The client gets a 500 (Internal Server Error) response instead.
Default: 0 (no maximum).

=cut

=attr memRequestBodyBytes

MemRequestBodyBytes defines the threshold (in bytes) from which the request will be buffered on disk instead of in memory.
Default: 1048576 (1Mi).

=cut

=attr memResponseBodyBytes

MemResponseBodyBytes defines the threshold (in bytes) from which the response will be buffered on disk instead of in memory.
Default: 1048576 (1Mi).

=cut

=attr retryExpression

RetryExpression defines the retry conditions.
It is a logical combination of functions with operators AND (&&) and OR (||).
More info: https://doc.traefik.io/traefik/v3.7/middlewares/http/buffering/#retryexpression

=cut

1;
