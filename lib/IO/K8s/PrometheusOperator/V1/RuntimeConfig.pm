package IO::K8s::PrometheusOperator::V1::RuntimeConfig;
# ABSTRACT: runtime defines the values for the Prometheus process behavior
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s goGC => Int, { minimum => -1 };

=attr goGC

goGC defines the Go garbage collection target percentage. Lowering this number may increase the CPU usage.
See: https://tip.golang.org/doc/gc-guide#GOGC

=cut

1;
