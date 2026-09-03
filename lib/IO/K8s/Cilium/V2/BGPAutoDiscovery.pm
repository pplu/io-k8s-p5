package IO::K8s::Cilium::V2::BGPAutoDiscovery;
# ABSTRACT: AutoDiscovery is the configuration for auto-discovery of the peer address.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s defaultGateway => '+IO::K8s::Cilium::V2::DefaultGateway';
k8s mode           => Str, { required => 'schema', enum => [qw(DefaultGateway)] };

=attr defaultGateway

defaultGateway is the configuration for auto-discovery of the default gateway.

=cut

=attr mode

mode is the mode of the auto-discovery.

=cut

1;
