package IO::K8s::PrometheusOperator::V1::QuerySpec;
# ABSTRACT: query defines the configuration of the Prometheus query service.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s lookbackDelta  => Str;
k8s maxConcurrency => Int, { minimum => 1 };
k8s maxSamples     => Int;
k8s timeout        => Str, { pattern => qr/^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$/ };

=attr lookbackDelta

lookbackDelta defines the delta difference allowed for retrieving metrics during expression evaluations.

=cut

=attr maxConcurrency

maxConcurrency defines the number of concurrent queries that can be run at once.

=cut

=attr maxSamples

maxSamples defines the maximum number of samples a single query can load into memory. Note that
queries will fail if they would load more samples than this into memory,
so this also limits the number of samples a query can return.

=cut

=attr timeout

timeout defines the maximum time a query may take before being aborted.

=cut

1;
