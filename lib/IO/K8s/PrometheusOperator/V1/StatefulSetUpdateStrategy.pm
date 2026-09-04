package IO::K8s::PrometheusOperator::V1::StatefulSetUpdateStrategy;
# ABSTRACT: updateStrategy indicates the strategy that will be employed to update Pods in the StatefulSet when a revision is made to statefulset's Pod Template.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s rollingUpdate => '+IO::K8s::PrometheusOperator::V1::RollingUpdateStatefulSetStrategy';
k8s type          => Str, { required => 'schema', enum => [qw(OnDelete RollingUpdate)] };

=attr rollingUpdate

rollingUpdate is used to communicate parameters when type is RollingUpdate.

=cut

=attr type

type indicates the type of the StatefulSetUpdateStrategy.

Default is RollingUpdate.

=cut

1;
