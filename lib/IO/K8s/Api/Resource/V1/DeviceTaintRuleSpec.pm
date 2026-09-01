package IO::K8s::Api::Resource::V1::DeviceTaintRuleSpec;
# ABSTRACT: DeviceTaintRuleSpec specifies the selector and one taint.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s deviceSelector => 'Resource::V1::DeviceTaintSelector';

=attr deviceSelector

DeviceSelector defines which device(s) the taint is applied to. All selector criteria must be satisfied for a device to match. The empty selector matches all devices. Without a selector, no devices are matches.

=cut

k8s taint => 'Resource::V1::DeviceTaint', 'required';

=attr taint

The taint that gets applied to matching devices.

=cut

1;
