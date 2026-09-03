package IO::K8s::Traefik::V1alpha1::RouterObservabilityConfig;
# ABSTRACT: Observability defines the observability configuration for a router.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s accessLogs     => Bool;
k8s metrics        => Bool;
k8s traceVerbosity => Str, { enum => [qw(minimal detailed)], default => 'minimal' };
k8s tracing        => Bool;

=attr accessLogs

AccessLogs enables access logs for this router.

=cut

=attr metrics

Metrics enables metrics for this router.

=cut

=attr traceVerbosity

TraceVerbosity defines the verbosity level of the tracing for this router.

=cut

=attr tracing

Tracing enables tracing for this router.

=cut

1;
