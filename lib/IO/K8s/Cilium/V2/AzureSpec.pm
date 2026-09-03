package IO::K8s::Cilium::V2::AzureSpec;
# ABSTRACT: Azure is the Azure IPAM specific configuration.
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'interface-name' => Str;

=attr interface-name

InterfaceName is the name of the interface the cilium-operator
will use to allocate all the IPs on

=cut

1;
