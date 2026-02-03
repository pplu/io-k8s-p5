package IO::K8s::Api::Discovery::V1::EndpointHints;
# ABSTRACT: EndpointHints provides hints describing how an endpoint should be consumed.

use IO::K8s::Resource;

k8s forZones => ['Discovery::V1::ForZone'];

=attr forZones

forZones indicates the zone(s) this endpoint should be consumed by to enable topology aware routing.

=cut

1;
