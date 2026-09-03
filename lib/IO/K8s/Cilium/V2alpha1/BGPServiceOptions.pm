package IO::K8s::Cilium::V2alpha1::BGPServiceOptions;
# ABSTRACT: Service defines configuration options for advertisementType service.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addresses             => [Str], { required => 'schema', enum => [qw(LoadBalancerIP ClusterIP ExternalIP)] };
k8s aggregationLengthIPv4 => Int, { minimum => 0, maximum => 31 };
k8s aggregationLengthIPv6 => Int, { minimum => 0, maximum => 127 };

=attr addresses

Addresses is a list of service address types which needs to be advertised via BGP.

=cut

=attr aggregationLengthIPv4

IPv4 mask to aggregate BGP route advertisements of service

=cut

=attr aggregationLengthIPv6

IPv6 mask to aggregate BGP route advertisements of service

=cut

1;
