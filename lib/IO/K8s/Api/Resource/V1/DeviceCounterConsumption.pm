package IO::K8s::Api::Resource::V1::DeviceCounterConsumption;
# ABSTRACT: DeviceCounterConsumption defines a set of counters that a device will consume from a CounterSet.
our $VERSION = '1.107';
use IO::K8s::Resource;

k8s counterSet => Str, 'required';

=attr counterSet

CounterSet is the name of the set from which the counters defined will be consumed.

=cut

k8s counters => { Str => 1 }, 'required';

=attr counters

Counters defines the counters that will be consumed by the device. The maximum number of counters is 32.

=cut

1;
