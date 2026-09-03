package IO::K8s::Traefik::V1alpha1::ResponseForwarding;
# ABSTRACT: ResponseForwarding defines how Traefik forwards the response from the upstream Kubernetes Service to the client.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s flushInterval => Str;

=attr flushInterval

FlushInterval defines the interval, in milliseconds, in between flushes to the client while copying the response body.
A negative value means to flush immediately after each write to the client.
This configuration is ignored when ReverseProxy recognizes a response as a streaming response;
for such responses, writes are flushed to the client immediately.
Default: 100ms

=cut

1;
