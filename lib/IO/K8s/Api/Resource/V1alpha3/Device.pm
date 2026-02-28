package IO::K8s::Api::Resource::V1alpha3::Device;
# ABSTRACT: Device represents one individual hardware instance that can be selected based on its attributes. Besides the name, exactly one field must be set.
our $VERSION = '1.006';
use IO::K8s::Resource;

k8s basic => 'Resource::V1alpha3::BasicDevice';

=attr basic

Basic defines one device instance.

=cut

k8s name => Str, 'required';

=attr name

Name is unique identifier among all devices managed by the driver in the pool. It must be a DNS label.

=cut

1;
