package IO::K8s::PrometheusOperator::V1::RollingUpdateStatefulSetStrategy;
# ABSTRACT: rollingUpdate is used to communicate parameters when type is RollingUpdate.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s maxUnavailable => IntOrStr;

=attr maxUnavailable

maxUnavailable is the maximum number of pods that can be unavailable
during the update. The value can be an absolute number (ex: 5) or a
percentage of desired pods (ex: 10%). Absolute number is calculated from
percentage by rounding up. This can not be 0.  Defaults to 1. This field
is alpha-level and is only honored by servers that enable the
MaxUnavailableStatefulSet feature. The field applies to all pods in the
range 0 to Replicas-1.  That means if there is any unavailable pod in
the range 0 to Replicas-1, it will be counted towards MaxUnavailable.

=cut

1;
