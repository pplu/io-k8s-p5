package IO::K8s::Cilium::V2::AzureAddress;
# ABSTRACT: AzureAddress is an IP address assigned to an AzureInterface
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s ip     => Str;
k8s state  => Str;
k8s subnet => Str;

=attr ip

IP is the ip address of the address

=cut

=attr state

State is the provisioning state of the address

=cut

=attr subnet

Subnet is the subnet the address belongs to.

Deprecated: use AzureInterface.Subnet.ID. Populated as a mirror for one
release so external consumers of CiliumNode.Status.Azure can migrate.

=cut

1;
