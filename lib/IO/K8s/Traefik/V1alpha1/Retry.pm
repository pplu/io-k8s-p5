package IO::K8s::Traefik::V1alpha1::Retry;
# ABSTRACT: Retry holds the retry middleware configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s attempts                   => Int, { minimum => 0 };
k8s disableRetryOnNetworkError => Bool;
k8s initialInterval            => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };
k8s maxRequestBodyBytes        => Int, { minimum => -1 };
k8s retryNonIdempotentMethod   => Bool;
k8s status                     => [Str], { pattern => qr/^([1-5][0-9]{2}[,-]?)+$/ };
k8s timeout                    => IntOrStr, { pattern => qr/^([0-9]+(ns|us|\x{b5}s|ms|s|m|h)?)+$/ };

=attr attempts

Attempts defines how many times the request should be retried.

=cut

=attr disableRetryOnNetworkError

DisableRetryOnNetworkError defines whether to disable the retry if an error occurs when transmitting the request to the server.

=cut

=attr initialInterval

InitialInterval defines the first wait time in the exponential backoff series.
The maximum interval is calculated as twice the initialInterval.
If unspecified, requests will be retried immediately.
The value of initialInterval should be provided in seconds or as a valid duration format,
see https://pkg.go.dev/time#ParseDuration.

=cut

=attr maxRequestBodyBytes

MaxRequestBodyBytes defines the maximum size for the request body.
Default is `-1`, which means no limit.

=cut

=attr retryNonIdempotentMethod

RetryNonIdempotentMethod activates the retry for non-idempotent methods (POST, LOCK, PATCH)

=cut

=attr status

Status defines the range of HTTP status codes to retry on.

=cut

=attr timeout

Timeout defines how much time the middleware is allowed to retry the request.
The value of timeout should be provided in seconds or as a valid duration format,
see https://pkg.go.dev/time#ParseDuration.

=cut

1;
