package IO::K8s::Api::Discovery::V1::ForZone;
# ABSTRACT: ForZone provides information about which zones should consume this endpoint.
our $VERSION = '1.001';
use IO::K8s::Resource;

k8s name => Str, 'required';

=attr name

name represents the name of the zone.

=cut

1;
