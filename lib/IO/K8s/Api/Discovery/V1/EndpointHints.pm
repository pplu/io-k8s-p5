package IO::K8s::Api::Discovery::V1::EndpointHints;
# ABSTRACT: EndpointHints provides hints describing how an endpoint should be consumed.
our $VERSION = '1.101';
use IO::K8s::Resource;

k8s forNodes => ['Discovery::V1::ForNode'];

=attr forNodes

forNodes indicates the node(s) this endpoint should be consumed by when using topology aware routing. May contain a maximum of 8 entries.

=cut

k8s forZones => ['Discovery::V1::ForZone'];

=attr forZones

forZones indicates the zone(s) this endpoint should be consumed by to enable topology aware routing.

=cut

1;
