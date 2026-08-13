package IO::K8s::Api::Resource::V1::Counter;
# ABSTRACT: Counter describes a quantity associated with a device.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s value => Quantity, 'required';

=attr value

Value defines how much of a certain device counter is available.

=cut

1;
