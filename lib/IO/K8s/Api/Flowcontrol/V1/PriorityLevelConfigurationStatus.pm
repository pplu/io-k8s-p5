package IO::K8s::Api::Flowcontrol::V1::PriorityLevelConfigurationStatus;
# ABSTRACT: PriorityLevelConfigurationStatus represents the current state of a "request-priority".
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s conditions => ['Flowcontrol::V1::PriorityLevelConfigurationCondition'];

=attr conditions

`conditions` is the current state of "request-priority".

=cut

1;
