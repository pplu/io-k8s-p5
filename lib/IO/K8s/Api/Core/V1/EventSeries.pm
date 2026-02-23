package IO::K8s::Api::Core::V1::EventSeries;
# ABSTRACT: EventSeries contain information on series of events, i.e. thing that was/is happening continuously for some time.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s count => Int;

=attr count

Number of occurrences in this series up to the last heartbeat time

=cut

k8s lastObservedTime => Str;

=attr lastObservedTime

Time of the last occurrence observed

=cut

1;
