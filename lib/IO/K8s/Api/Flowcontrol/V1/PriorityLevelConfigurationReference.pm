package IO::K8s::Api::Flowcontrol::V1::PriorityLevelConfigurationReference;
# ABSTRACT: PriorityLevelConfigurationReference contains information that points to the "request-priority" being used.
our $VERSION = '1.005';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

`name` is the name of the priority level configuration being referenced Required.

=cut

1;
