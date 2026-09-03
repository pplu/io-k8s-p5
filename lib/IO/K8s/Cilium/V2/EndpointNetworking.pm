package IO::K8s::Cilium::V2::EndpointNetworking;
# ABSTRACT: Networking is the networking properties of the endpoint.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addressing => ['+IO::K8s::Cilium::V2::AddressPair'], { required => 'schema' };
k8s node       => Str;

=attr addressing

IP4/6 addresses assigned to this Endpoint

=cut

=attr node

NodeIP is the IP of the node the endpoint is running on. The IP must
be reachable between nodes.

=cut

1;
