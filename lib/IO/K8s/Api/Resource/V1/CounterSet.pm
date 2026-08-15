package IO::K8s::Api::Resource::V1::CounterSet;
# ABSTRACT: CounterSet defines a named set of counters that are available to be used by devices defined in the ResourcePool.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s counters => { 'Resource::V1::Counter' => 1 }, 'required';

=attr counters

Counters defines the set of counters for this CounterSet. The name of each counter must be unique in that set and must be a DNS label. The maximum number of counters is 32.

The counters are not allocatable by themselves, but can be referenced by devices. When a device is allocated, the portion of counters it uses will no longer be available for use by other devices.

=cut

k8s name => Str, 'required';

=attr name

Name defines the name of the counter set. It must be a DNS label.

=cut

1;
