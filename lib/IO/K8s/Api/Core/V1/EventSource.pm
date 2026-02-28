package IO::K8s::Api::Core::V1::EventSource;
# ABSTRACT: EventSource contains information for an event.
our $VERSION = '1.004';
use IO::K8s::Resource;

k8s component => Str;

=attr component

Component from which the event is generated.

=cut

k8s host => Str;

=attr host

Node name on which the event is generated.

=cut

1;
