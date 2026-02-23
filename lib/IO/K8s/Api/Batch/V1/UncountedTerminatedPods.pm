package IO::K8s::Api::Batch::V1::UncountedTerminatedPods;
# ABSTRACT: UncountedTerminatedPods holds UIDs of Pods that have terminated but haven't been accounted in Job status counters.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s failed => [Str];

=attr failed

failed holds UIDs of failed Pods.

=cut

k8s succeeded => [Str];

=attr succeeded

succeeded holds UIDs of succeeded Pods.

=cut

1;
