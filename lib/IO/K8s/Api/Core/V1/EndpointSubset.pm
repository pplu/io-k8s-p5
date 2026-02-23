package IO::K8s::Api::Core::V1::EndpointSubset;
# ABSTRACT: EndpointSubset is a group of addresses with a common set of ports. The expanded set of endpoints is the Cartesian product of Addresses x Ports.
our $VERSION = '1.003';
use IO::K8s::Resource;

k8s addresses => ['Core::V1::EndpointAddress'];

=attr addresses

IP addresses which offer the related ports that are marked as ready. These endpoints should be considered safe for load balancers and clients to utilize.

=cut

k8s notReadyAddresses => ['Core::V1::EndpointAddress'];

=attr notReadyAddresses

IP addresses which offer the related ports but are not currently marked as ready because they have not yet finished starting, have recently failed a readiness check, or have recently failed a liveness check.

=cut

k8s ports => ['Core::V1::EndpointPort'];

=attr ports

Port numbers available on the related IP addresses.

=cut

1;
