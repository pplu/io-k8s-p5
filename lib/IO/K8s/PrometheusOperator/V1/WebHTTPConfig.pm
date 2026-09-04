package IO::K8s::PrometheusOperator::V1::WebHTTPConfig;
# ABSTRACT: httpConfig defines HTTP parameters for web server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s headers => '+IO::K8s::PrometheusOperator::V1::WebHTTPHeaders';
k8s http2   => Bool;

=attr headers

headers defines a list of headers that can be added to HTTP responses.

=cut

=attr http2

http2 enable HTTP/2 support. Note that HTTP/2 is only supported with TLS.
When TLSConfig is not configured, HTTP/2 will be disabled.
Whenever the value of the field changes, a rolling update will be triggered.

=cut

1;
