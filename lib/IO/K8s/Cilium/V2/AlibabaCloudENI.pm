package IO::K8s::Cilium::V2::AlibabaCloudENI;
# ABSTRACT: ENI represents an AlibabaCloud Elastic Network Interface
our $VERSION = '1.108';
use IO::K8s::Resource;

k8s 'instance-id'          => Str;
k8s 'mac-address'          => Str;
k8s 'network-interface-id' => Str;
k8s 'primary-ip-address'   => Str;
k8s 'private-ipsets'       => ['+IO::K8s::Cilium::V2::PrivateIPSet'];
k8s 'security-groupids'    => [Str];
k8s tags                   => { Str => 1 };
k8s type                   => Str;
k8s vpc                    => '+IO::K8s::Cilium::V2::VPC';
k8s vswitch                => '+IO::K8s::Cilium::V2::VSwitch';
k8s 'zone-id'              => Str;

=attr instance-id

InstanceID is the InstanceID using this ENI

=cut

=attr mac-address

MACAddress is the mac address of the ENI

=cut

=attr network-interface-id

NetworkInterfaceID is the ENI id

=cut

=attr primary-ip-address

PrimaryIPAddress is the primary IP on ENI

=cut

=attr private-ipsets

PrivateIPSets is the list of all IPs on the ENI, including PrimaryIPAddress

=cut

=attr security-groupids

SecurityGroupIDs is the security group ids used by this ENI

=cut

=attr tags

Tags is the tags on this ENI

=cut

=attr type

Type is the ENI type Primary or Secondary

=cut

=attr vpc

VPC is the vpc to which the ENI belongs

=cut

=attr vswitch

VSwitch is the vSwitch the ENI is using

=cut

=attr zone-id

ZoneID is the zone to which the ENI belongs

=cut

1;
