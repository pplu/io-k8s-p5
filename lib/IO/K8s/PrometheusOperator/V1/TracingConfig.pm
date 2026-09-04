package IO::K8s::PrometheusOperator::V1::TracingConfig;
# ABSTRACT: tracingConfig defines tracing in Prometheus.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s clientType       => Str, { enum => [qw(http grpc HTTP GRPC)] };
k8s compression      => Str, { enum => [qw(gzip Gzip)] };
k8s endpoint         => Str, { required => 'schema' };
k8s headers          => { Str => 1 };
k8s insecure         => Bool;
k8s samplingFraction => IntOrStr, { pattern => qr/^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$/ };
k8s timeout          => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };
k8s tlsConfig        => '+IO::K8s::PrometheusOperator::V1::TLSConfig';

=attr clientType

clientType defines the client used to export the traces. Supported values are `HTTP` and `GRPC`.

=cut

=attr compression

compression key for supported compression types. The only supported value is `Gzip`.

=cut

=attr endpoint

endpoint to send the traces to. Should be provided in format <host>:<port>.

=cut

=attr headers

headers defines the key-value pairs to be used as headers associated with gRPC or HTTP requests.

=cut

=attr insecure

insecure if disabled, the client will use a secure connection.

=cut

=attr samplingFraction

samplingFraction defines the probability a given trace will be sampled. Must be a float from 0 through 1.

=cut

=attr timeout

timeout defines the maximum time the exporter will wait for each batch export.

=cut

=attr tlsConfig

tlsConfig to use when sending traces.

=cut

1;
