package IO::K8s::Api::Apps::V1::DaemonSetUpdateStrategy;
# ABSTRACT: DaemonSetUpdateStrategy is a struct used to control the update strategy for a DaemonSet.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s rollingUpdate => 'Apps::V1::RollingUpdateDaemonSet';

=attr rollingUpdate

Rolling update config params. Present only if type = "RollingUpdate".

=cut

k8s type => Str;

=attr type

Type of daemon set update. Can be "RollingUpdate" or "OnDelete". Default is RollingUpdate.

=cut

1;
