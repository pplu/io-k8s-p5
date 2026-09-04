package IO::K8s::PrometheusOperator::V1::PrometheusWebSpec;
# ABSTRACT: web defines the configuration of the Prometheus web server.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s httpConfig     => '+IO::K8s::PrometheusOperator::V1::WebHTTPConfig';
k8s maxConnections => Int, { minimum => 0 };
k8s pageTitle      => Str;
k8s tlsConfig      => '+IO::K8s::PrometheusOperator::V1::WebTLSConfig';

=attr httpConfig

httpConfig defines HTTP parameters for web server.

=cut

=attr maxConnections

maxConnections defines the maximum number of simultaneous connections
A zero value means that Prometheus doesn't accept any incoming connection.

=cut

=attr pageTitle

pageTitle defines the prometheus web page title.

=cut

=attr tlsConfig

tlsConfig defines the TLS parameters for HTTPS.

=cut

1;
