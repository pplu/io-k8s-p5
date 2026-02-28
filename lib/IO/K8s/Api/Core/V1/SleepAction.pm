package IO::K8s::Api::Core::V1::SleepAction;
# ABSTRACT: SleepAction describes a "sleep" action.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s seconds => Int, 'required';

=attr seconds

Seconds is the number of seconds to sleep.

=cut

1;
