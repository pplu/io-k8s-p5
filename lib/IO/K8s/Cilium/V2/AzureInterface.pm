package IO::K8s::Cilium::V2::AzureInterface;
# ABSTRACT: AzureInterface represents an Azure Interface
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s addresses        => ['+IO::K8s::Cilium::V2::AzureAddress'];
k8s cidr             => Str;
k8s gateway          => Str;
k8s id               => Str;
k8s ip               => Str;
k8s mac              => Str;
k8s name             => Str;
k8s 'security-group' => Str;
k8s state            => Str;
k8s subnet           => '+IO::K8s::Cilium::V2::AzureSubnet';

=attr addresses

Addresses is the list of secondary IPs associated with the interface.
The primary IP is tracked separately in the IP field, but is also
included here when the operator is configured to expose it for
allocation.

=cut

=attr cidr

CIDR is the range that the interface belongs to.

Deprecated: use Subnet.CIDR. Retained for one release so agent/operator
rolling upgrades work in either order.

=cut

=attr gateway

Gateway is the interface's subnet's default route

=cut

=attr id

ID is the identifier

=cut

=attr ip

IP is the primary IP of the interface

=cut

=attr mac

MAC is the mac address

=cut

=attr name

Name is the name of the interface

=cut

=attr security-group

SecurityGroup is the security group associated with the interface

=cut

=attr state

State is the provisioning state

=cut

=attr subnet

Subnet is the subnet the interface is attached to.

=cut

1;
