package IO::K8s::Cilium::V2::DefaultGateway;
# ABSTRACT: defaultGateway is the configuration for auto-discovery of the default gateway.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addressFamily => Str, { required => 'schema', enum => [qw(ipv4 ipv6)] };

=attr addressFamily

addressFamily is the address family of the default gateway.

=cut

1;
