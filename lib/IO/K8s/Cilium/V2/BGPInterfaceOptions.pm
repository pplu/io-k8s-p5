package IO::K8s::Cilium::V2::BGPInterfaceOptions;
# ABSTRACT: Interface defines configuration options for the "Interface" advertisementType.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s name => Str, { required => 'schema' };

=attr name

Name of local interface of whose IP addresses will be advertised via BGP.
Each IP address applied on the interface is advertised as a /32 prefix (for IPv4) or a /128 prefix (for IPv6).

=cut

1;
