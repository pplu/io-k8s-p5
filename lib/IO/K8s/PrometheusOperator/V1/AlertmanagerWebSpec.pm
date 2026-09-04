package IO::K8s::PrometheusOperator::V1::AlertmanagerWebSpec;
# ABSTRACT: web defines the web command line flags when starting Alertmanager.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s getConcurrency => Int, { minimum => 0 };
k8s httpConfig     => '+IO::K8s::PrometheusOperator::V1::WebHTTPConfig';
k8s timeout        => Int, { minimum => 0 };
k8s tlsConfig      => '+IO::K8s::PrometheusOperator::V1::WebTLSConfig';

=attr getConcurrency

getConcurrency defines the maximum number of GET requests processed concurrently. This corresponds to the
Alertmanager's `--web.get-concurrency` flag.

=cut

=attr httpConfig

httpConfig defines HTTP parameters for web server.

=cut

=attr timeout

timeout for HTTP requests. This corresponds to the Alertmanager's
`--web.timeout` flag.

=cut

=attr tlsConfig

tlsConfig defines the TLS parameters for HTTPS.

=cut

1;
