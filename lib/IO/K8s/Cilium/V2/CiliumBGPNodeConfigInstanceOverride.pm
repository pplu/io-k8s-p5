package IO::K8s::Cilium::V2::CiliumBGPNodeConfigInstanceOverride;
# ABSTRACT: CiliumBGPNodeConfigInstanceOverride defines configuration options which can be overridden for a specific BGP instance.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s localASN  => Int, { minimum => 1, maximum => 4294967295 };
k8s localPort => Int;
k8s name      => Str, { required => 'schema' };
k8s peers     => ['+IO::K8s::Cilium::V2::CiliumBGPNodeConfigPeerOverride'];
k8s routerID  => Str;

=attr localASN

LocalASN is the ASN to use for this BGP instance.

=cut

=attr localPort

LocalPort is port to use for this BGP instance.

=cut

=attr name

Name is the name of the BGP instance for which the configuration is overridden.

=cut

=attr peers

Peers is a list of peer configurations to override.

=cut

=attr routerID

RouterID is BGP router id to use for this instance. It must be unique across all BGP instances.

=cut

1;
