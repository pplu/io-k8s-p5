package IO::K8s::Api::Resource::V1beta2::DeviceTaintSelector;
# ABSTRACT: DeviceTaintSelector defines which device(s) a DeviceTaintRule applies to. The empty selector matches all devices. Without a selector, no devices are matched.
our $VERSION = '1.105';
use IO::K8s::Resource;

k8s device => Str;

=attr device

If device is set, only devices with that name are selected. This field corresponds to slice.spec.devices[].name. Setting also driver and pool may be required to avoid ambiguity, but is not required.

=cut

k8s driver => Str;

=attr driver

If driver is set, only devices from that driver are selected. This fields corresponds to slice.spec.driver.

=cut

k8s pool => Str;

=attr pool

If pool is set, only devices in that pool are selected. Also setting the driver name may be useful to avoid ambiguity when different drivers use the same pool name, but this is not required because selecting pools from different drivers may also be useful, for example when drivers with node-local devices use the node name as their pool name.

=cut

1;
