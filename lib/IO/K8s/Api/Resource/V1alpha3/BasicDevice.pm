package IO::K8s::Api::Resource::V1alpha3::BasicDevice;
# ABSTRACT: BasicDevice defines one device instance.
our $VERSION = '1.002';
use IO::K8s::Resource;

k8s attributes => { 'Resource::V1alpha3::DeviceAttribute' => 1 };

=attr attributes

Attributes defines the set of attributes for this device. The name of each attribute must be unique in that set.

The maximum number of attributes and capacities combined is 32.

=cut

k8s capacity => { Str => 1 };

=attr capacity

Capacity defines the set of capacities for this device. The name of each capacity must be unique in that set.

The maximum number of attributes and capacities combined is 32.

=cut

1;
