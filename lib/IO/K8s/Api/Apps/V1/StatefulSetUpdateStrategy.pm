package IO::K8s::Api::Apps::V1::StatefulSetUpdateStrategy;
# ABSTRACT: StatefulSetUpdateStrategy indicates the strategy that the StatefulSet controller will use to perform updates.
our $VERSION = '1.007';
use IO::K8s::Resource;

k8s rollingUpdate => 'Apps::V1::RollingUpdateStatefulSetStrategy';

=attr rollingUpdate

RollingUpdate is used to communicate parameters when Type is RollingUpdateStatefulSetStrategyType.

=cut

k8s type => Str;

=attr type

Type indicates the type of the StatefulSetUpdateStrategy. Default is RollingUpdate.

=cut

1;
