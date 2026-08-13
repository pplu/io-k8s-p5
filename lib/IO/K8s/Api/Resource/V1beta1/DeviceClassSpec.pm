package IO::K8s::Api::Resource::V1beta1::DeviceClassSpec;
# ABSTRACT: DeviceClassSpec is used in a [DeviceClass] to define what can be allocated and how to configure it.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s config => ['Resource::V1beta1::DeviceClassConfiguration'];

=attr config

Config defines configuration parameters that apply to each device that is claimed via this class. Some classses may potentially be satisfied by multiple drivers, so each instance of a vendor configuration applies to exactly one driver.  They are passed to the driver, but are not considered while allocating the claim.

=cut

k8s extendedResourceName => Str;

=attr extendedResourceName

ExtendedResourceName is the extended resource name for the devices of this class. The devices of this class can be used to satisfy a pod's extended resource requests. It has the same format as the name of a pod's extended resource. It should be unique among all the device classes in a cluster. If two device classes have the same name, then the class created later is picked to satisfy a pod's extended resource requests. If two classes are created at the same time, then the name of the class lexicographically sorted first is picked.  This is a beta field.

=cut

k8s selectors => ['Resource::V1beta1::DeviceSelector'];

=attr selectors

Each selector must be satisfied by a device which is claimed via this class.

=cut

1;
